import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gold_price/screens/auth_screens/otp_screen.dart';
import 'package:gold_price/screens/dashboard_screen/dashboard_screen.dart';
import 'package:gold_price/utils/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response_models/user_data_model.dart';
import '../services/user_data.dart';

class AuthController extends GetxController {
 RxBool isEnglish=true.obs;
 RxBool isUrdu=false.obs;
 TextEditingController pinPutController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
 final pinPutFocusNode = FocusNode();
 String otp='';
 RxBool isOtp=false.obs;
 Rx<Color> buttonClr=AppColors.white.obs;
 Rx<Color> buttonTextClr=AppColors.primaryColor.obs;

final _auth = FirebaseAuth.instance;
  RxBool isIdGet=false.obs;


  //FUNC
  Future<void> phoneAuthentication(String phoneNo) async {
    isIdGet.value=true;
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (verificationId, resendToken) {
        isIdGet.value=false;
        print('verificationId in codeSent:: $verificationId');
        Get.to(()=>OtpScreen(verifyId: verificationId,));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print('verificationId in codeAutoRetrievalTimeout:: $verificationId');
        isIdGet.value=false;
      },
      verificationFailed: (e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.');
          isIdGet.value=false;
        } else {
          Get.snackbar('Error', 'Something went wrong. Try again.');
          isIdGet.value=false;
        }
      },
    );
  }

 Future verifyOTP(String otp,String verifyId) async {
   isOtp.value=true;
   var credentials = await _auth.signInWithCredential(
       PhoneAuthProvider.credential(
           verificationId: verifyId, smsCode: otp));
   print("otp response is this:::${credentials.user.toString()}");
   if( credentials.user != null ){
     final token=await FirebaseMessaging.instance.getToken();
     final sharedPrefs = await SharedPreferences.getInstance();
     UserPersistence userPersistence =  UserPersistence(sharedPrefs);
     userPersistence.save(UserPersistenceData(
       accessToken: token,
       uid: credentials.user!.uid??'',
       number:credentials.user!.phoneNumber??'',
     ));
     await FirebaseMessaging.instance.subscribeToTopic('/topics/saadGold');
     isOtp.value=false;
     Get.offAll(()=>const DasBoardScreen());
   }else{
     Get.snackbar('Wrong Otp', "Please Enter Correct Otp");
     isOtp.value=false;
     Get.back();
   }
 }


 /// check login
 Future<bool> isLogin()async{
   final sharedPrefs = await SharedPreferences.getInstance();
   UserPersistence userPersistence =  UserPersistence(sharedPrefs);
   UserPersistenceData userData = userPersistence.load();
   return userData.accessToken!=null&&userData.accessToken!.isNotEmpty?true:false;

 }

 void onChangeLanguage(var language ){
    var local=Locale(language);
    Get.updateLocale(local);
 }
}
