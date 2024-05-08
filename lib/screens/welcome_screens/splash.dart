import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_price/utils/image_assets.dart';
import '../../controller/auth_controller.dart';
import '../auth_screens/login.dart';
import '../dashboard_screen/dashboard_screen.dart';

class SplashScreen extends StatelessWidget {
 
  SplashScreen({Key? key}) : super(key: key);
  AuthController authController=Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      // Get Settings Data First If required
      authController.isLogin().then((value) async {
        if (value==true) {
          Get.offAll(() => const DasBoardScreen());
        } else {
          Get.offAll(() => LoginScreen());
        }
      });
    });
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image:AssetImage(ImageAssets.splashBG),fit: BoxFit.cover ),
      ),
    );
  }
}
