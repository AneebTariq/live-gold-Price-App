import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gold_price/utils/app_colors.dart';
import '../../utils/app_text_styles.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.images, this.name, this.crt, this.weight});
final List? images;
final String? name;
final String? crt;
final String? weight;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 150.h,),
            SizedBox(
              height: 400.h,
              width: 400.w,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.images?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:  EdgeInsets.only(right: 16.w),
                    child: Hero(
                      tag: "hero-grid1-2",
                      child: InteractiveViewer(
                        child: Image.network(
                          widget.images?[index],
                           width: 400.w,
                          // height: 300.h,
                          alignment: Alignment.center,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 20.h,
              child: ListView.builder(
                itemCount: widget.images?.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10.w,),
                      height: 20.h,
                      width: 20.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: 50.h,
            ),
            Center(
              child: Text(
                '${widget.name}',
                style: AppTextStyles.font24TextStyle
                    .copyWith(color: AppColors.primaryColor),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.crt}ct Gold',
                  style: AppTextStyles.font16TextStyle
                      .copyWith(color: AppColors.primaryColor),
                ),
                SizedBox(
                  width: 50.h,
                ),
                RichText(
                  text: TextSpan(
                    text: 'weight'.tr,
                    style: AppTextStyles.font16TextStyle.copyWith(color: AppColors.primaryColor),
                    children: <TextSpan>[
                      TextSpan(
                        text: ': ${widget.weight}g',
                        style: AppTextStyles.font16TextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}