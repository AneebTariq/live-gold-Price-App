import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gold_price/utils/app_colors.dart';
import 'package:gold_price/utils/app_text_styles.dart';
import '../../models/response_models/jewelry_model.dart';
import '../../widgets/custom_appbar.dart';
import 'image_detail_screen.dart';

class JewelryScreen extends StatelessWidget {
  const JewelryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(
        height: 80.h,
        title: 'jewelry'.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 22.h,
              ),
               StreamBuilder(
                stream: FirebaseDatabase.instance
                    .reference()
                    .child('Jewelry')
                    .onValue,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // Extract data from the snapshot
                    Map<dynamic, dynamic>? jewelryData =
                        snapshot.data?.snapshot.value;
                    if (jewelryData != null) {
                      // Convert the map to a list of jewelry items
                      List<JewelryItem> jewelryList = jewelryData.entries
                          .map((entry) =>
                              JewelryItem.fromMap(entry.key, entry.value))
                          .toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: jewelryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Build your UI using the jewelry items
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Container(
                              // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                border:
                                    Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Hero(
                                            tag: "hero-grid-1",
                                            child: Material(
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>  DetailPage(
                                                        images: jewelryList[index].imageUrls,
                                                        name:jewelryList[index].name ,
                                                        crt:jewelryList[index].crt ,
                                                        weight:jewelryList[index].weight ,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  height: 200.h,
                                                  width: double.infinity,
                                                  child: ClipRRect(
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(10),
                                                      topRight: Radius.circular(10),
                                                    ),
                                                    child: Image.network(
                                                    jewelryList[index].imageUrls.first,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Center(
                                    child: Text(
                                      jewelryList[index].name,
                                      style: AppTextStyles.font14_600TextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Text(
                                      '${jewelryList[index].crt}ct Gold',
                                      style: AppTextStyles.font14_600TextStyle
                                          .copyWith(
                                              color: AppColors.primaryColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'weight'.tr,
                                        style: AppTextStyles.font16TextStyle.copyWith(color: AppColors.primaryColor),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: ': ${jewelryList[index].weight}g',
                                            style: AppTextStyles.font16TextStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }
                  // Show loading indicator or error message if data is not available
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              // ListView.builder(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   itemCount: 10, // number of items in your grid
              //   itemBuilder: (BuildContext context, int index) {
              //     return Padding(
              //       padding: EdgeInsets.only(bottom: 16.h),
              //       child: Container(
              //         // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              //         decoration: BoxDecoration(
              //           color: AppColors.white,
              //           border: Border.all(color: AppColors.primaryColor),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Hero(
              //               tag: "hero-grid-1",
              //               child: Material(
              //                 child: InkWell(
              //                   onTap: () {
              //                     Navigator.of(context).push(
              //                       MaterialPageRoute(
              //                         builder: (context) => const DetailPage(),
              //                       ),
              //                     );
              //                   },
              //                   child: SizedBox(
              //                     height: 200.h,
              //                     width: double.infinity,
              //                     child: ClipRRect(
              //                       borderRadius: const BorderRadius.only(
              //                         topLeft: Radius.circular(10),
              //                         topRight: Radius.circular(10),
              //                       ),
              //                       child: Image.network(
              //                         'https://kikidi.pk/wp-content/uploads/2020/10/1-5.jpg',
              //                         fit: BoxFit.cover,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 5.h,
              //             ),
              //             Center(
              //               child: Text(
              //                 'Product Name',
              //                 style: AppTextStyles.font14_600TextStyle
              //                     .copyWith(color: AppColors.primaryColor),
              //               ),
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 16.w),
              //               child: Text(
              //                 '18ct Gold',
              //                 style: AppTextStyles.font14_600TextStyle
              //                     .copyWith(color: AppColors.primaryColor),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 4.h,
              //             ),
              //             Padding(
              //               padding: EdgeInsets.symmetric(horizontal: 16.w),
              //               child: Text(
              //                 'Weight: 6.08g',
              //                 style: AppTextStyles.font14_600TextStyle
              //                     .copyWith(color: AppColors.primaryColor),
              //               ),
              //             ),
              //             SizedBox(
              //               height: 10.h,
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // )
              // dgdfsfhhgs
            ],
          ),
        ),
      ),
    );
  }
}
