import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/res/string/app_string.dart';
import 'package:gotaco/src/ui/screen/splash/splash_controller.dart';
import 'package:gotaco/src/ui/widget/app_container.dart';

import '../../theme/app_color.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.sp,
            width: 50.sp,
            child: const CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          ),
          Gap(20.sp),
          Text(
            StringConstants.welcome.tr,
            textScaleFactor: 1,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 25.sp,
            ),
          )
        ],
      ),
    );
  }
}
