import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/ui/screen/home/home_controller.dart';

import '../../../../res/image/app_image.dart';
import '../../../../res/string/app_string.dart';
import '../../../theme/app_color.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';


class NotificationWidget extends GetView<HomeController>{
  const NotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          StringConstants.notification.tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColor.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        Gap(4.sp),
        Container(
          height: 4.sp,
          width: Get.width - 24.sp,
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
            color: Color(0xFF677FFF),
          ),
        ),
        Gap(4.sp),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            itemCount: controller.listNotification.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.sp,
                  horizontal: 12.sp,
                ),
                margin: EdgeInsets.symmetric(
                  vertical: 6.sp,
                ),
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColor.black.withOpacity(0.2),
                      width: 0.5.sp,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(1, 3),
                        blurRadius: 5,
                        spreadRadius: 0,
                        color: AppColor.black.withOpacity(0.25),
                      )
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppImageWidget.asset(
                      path: AppImage.icChip,
                      height: 24.sp,
                    ),
                    Gap(10.sp),
                    Expanded(
                      child: Text(
                        controller.listNotification[index],
                        style: TextStyle(
                          color: AppColor.blackE1E,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

}