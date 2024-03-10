import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/ui/router/app_router.dart';

class SplashController extends GetxController {
  late BuildContext context;

  @override
  void onInit() {
    initData();
    super.onInit();
  }

  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offAndToNamed(AppRouter.homeScreen);

    super.onReady();
  }

  void initData() async {}
}
