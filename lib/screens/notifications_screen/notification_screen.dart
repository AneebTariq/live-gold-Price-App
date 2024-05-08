import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gold_price/utils/app_text_styles.dart';
import '../../utils/app_colors.dart';
import '../../widgets/custom_appbar.dart';

class NotificationScreen extends StatelessWidget {
   NotificationScreen({super.key,});
final notifications=FirebaseDatabase.instance.ref('Notifications');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        height: 80.h,
        title: 'notifications'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal:16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 22.h,),
              StreamBuilder(
                stream: notifications.onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator()); // Show loading indicator while data is loading
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                    return Text('No data available');
                  }
                  final Map<dynamic, dynamic>? rawData = snapshot.data?.snapshot.value as Map<dynamic, dynamic>?;

                  if (rawData == null) {
                    return const Text('Data not available');
                  }
                  final Map<String, dynamic> data = rawData.cast<String, dynamic>();
                  List<dynamic> notify=[];
                  notify=data.values.toList();
                  return  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: notify.length,
                      itemBuilder: (context, index){
                        return Padding(
                          padding:  EdgeInsets.only(bottom: 20.h),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 10.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [AppColors.buttonClr,AppColors.primaryColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius:  BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${notify[index]['title']}',
                                        style: AppTextStyles.font16TextStyle.copyWith(color: AppColors.white),),
                                      SizedBox(height: 5.h,),
                                      Text('${notify[index]['body']}',style: AppTextStyles.font14_400TextStyle.copyWith(color: AppColors.white.withOpacity(0.7)),),
                                    ],
                                  ),
                                ),
                                Text('${notify[index]['date']}',style: AppTextStyles.font14_400TextStyle.copyWith(color: AppColors.white),)
                              ],
                            ),
                          ),
                        );
                      });

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
