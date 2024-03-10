import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/res/image/app_image.dart';
import 'package:gotaco/src/ui/widget/app_container.dart';
import 'package:gotaco/src/ui/widget/app_image_widget.dart';
import 'package:gotaco/src/ui/widget/app_touchable.dart';

import '../theme/app_color.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    this.title,
    this.leftWidget,
    this.middleWidget,
    this.rightWidget,
    this.extendWidget,
  });

  final String? title;
  final Widget? leftWidget;
  final Widget? middleWidget;
  final Widget? rightWidget;
  final Widget? extendWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColor.white,
      ),
      // padding: EdgeInsets.symmetric(horizontal: 20.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leftWidget ??
              AppTouchable(
                onPressed: Get.back,
                height: 40.sp,
                width: 40.sp,
                padding: EdgeInsets.all(2.sp),
                child: AppImageWidget.asset(path: AppImage.icBack),
              ),
          Expanded(
            child: middleWidget ??
                Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
          ),
          rightWidget ?? Gap(40.sp),
        ],
      ),
    );
  }
}
