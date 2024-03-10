import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/res/string/app_string.dart';
import 'package:gotaco/src/ui/screen/home/widget/machine_list.dart';
import 'package:gotaco/src/ui/screen/home/widget/noti.dart';
import 'package:gotaco/src/ui/widget/app_container.dart';
import 'package:gotaco/src/ui/widget/app_image_widget.dart';
import 'package:gotaco/src/ui/widget/app_touchable.dart';
import 'package:gotaco/src/util/disable_glow_behavior.dart';

import '../../../res/image/app_image.dart';
import '../../../widget/app_chart.dart';
import '../../theme/app_color.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    RxList<double> listValue = <double>[
      1,
      2,
      3,
      1,
      2,
      4,
      1,
      4,
      7,
      2,
      9,
      75,
      2,
      3,
      1,
      2,
      4,
      1,
      4,
      7,
      2,
      9,
      0,
      8,
    ].obs;

    return AppContainer(
      bottomNavigationBar: Container(
        height: 50.sp,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.sp),
            topRight: Radius.circular(10.sp),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Obx(
              () => AppTouchable(
                onPressed: () {
                  controller.selectedPage.value = 0;
                },
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                child: AppImageWidget.asset(
                  path: controller.selectedPage.value != 1
                      ? AppImage.icHome
                      : AppImage.icHomeUnselect,
                ),
              ),
            ),
            Obx(
              () => AppTouchable(
                onPressed: () {
                  controller.selectedPage.value = 1;
                },
                padding:
                    EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
                child: AppImageWidget.asset(
                  path: controller.selectedPage.value == 1
                      ? AppImage.icNoti
                      : AppImage.icNotiUnselect,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Obx(
        () => controller.selectedPage.value == 0
            ? buildPageHome(
                listValue: listValue,
              )
            : controller.selectedPage.value == 1
                ? const NotificationWidget()
                : const MachineListWidget(),
      ),
    );
  }

  Widget buildPageHome({required RxList<double> listValue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFFDADEFA),
          padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildRoomName(room: controller.room.value),
                  Text(
                    StringConstants.gotaco.tr.toUpperCase(),
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20.sp,
                        fontFamily: "Nunito",
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Gap(15.sp),
              Text(
                controller.currentDate,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gap(15.sp),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildInfoEmission(
                        imgPath: AppImage.imgCO,
                        value: "${controller.percentCO.value}% CO"),
                    buildInfoEmission(
                        imgPath: AppImage.imgTemperature,
                        value: "${controller.temperature.value}℃"),
                    buildInfoEmission(
                        imgPath: AppImage.imgHumidity,
                        value: "${controller.humidity.value}℃"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: DisableGlowBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLineChart(
                    dataList: listValue,
                    maxY: 100,
                    backgroundColor: AppColor.primaryColor,
                    type: "%",
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringConstants.listMachine.tr,
                          style: TextStyle(
                            color: AppColor.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        Gap(10.sp),
                        Container(
                          height: 4.sp,
                          width: Get.width,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          decoration: const BoxDecoration(
                            color: Color(0xFF677FFF),
                          ),
                        ),
                        Gap(8.sp),
                        buildListMachine()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildInfoEmission({required String imgPath, required String value}) {
    return Row(
      children: [
        AppImageWidget.asset(
          path: imgPath,
          height: 30.sp,
        ),
        Gap(6.sp),
        Text(
          value,
          style: TextStyle(
            color: AppColor.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildListMachine() {
    return AppTouchable(
      onPressed: () {
        controller.selectedPage.value = 3;
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: min(3, controller.listMachine.length),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var item = controller.listMachine[index];
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
                    item["name"],
                    style: TextStyle(
                      color: AppColor.blackE1E,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  item["percentValue"],
                  style: TextStyle(
                    color: AppColor.blackE1E,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRoomName({required String room}) {
    return AppTouchable(
      onPressed: () {},
      decoration: BoxDecoration(
        color: const Color(0xFF6E96FD),
        borderRadius: BorderRadius.circular(42),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
      child: Text(
        "Room $room",
        style: TextStyle(
            color: AppColor.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
