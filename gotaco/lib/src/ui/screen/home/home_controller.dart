import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/ui/app/app_controller.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  late BuildContext context;

  RxInt percentCO = 0.obs;
  RxInt percentWind = 0.obs;
  RxInt percentCO2 = 0.obs;
  RxInt percentAncol = 0.obs;
  RxInt valueABCXYZ = 0.obs;
  RxString room = "".obs;
  RxString warning = "".obs;
  String currentDate = "";
  RxInt temperature = 0.obs;
  RxInt humidity = 0.obs;

  RxList listMachine = [].obs;
  RxList listNotification = [].obs;

  RxInt selectedPage = 0.obs;
  final AppController appController = Get.find<AppController>();

  RxList<double> listDataCO = <double>[].obs;

  @override
  void onInit() {
    listDataCO.value = [0, 0];
    percentCO.value = 20;
    percentWind.value = 2;
    temperature.value = 20;
    humidity.value = 28;
    room.value = "1 - A0";
    warning.value = "Safe";
    currentDate = DateFormat('EEEE, dd MMMM').format(DateTime.now());
    listMachine.value = [
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
      {
        "name": "Máy 1",
        "percentValue": "20%",
        "minTemp": "11°",
        "maxTemp": "24°",
      },
      {
        "name": "Máy 2",
        "percentValue": "15%",
        "minTemp": "14°",
        "maxTemp": "20°",
      },
      {
        "name": "Máy 3",
        "percentValue": "30%",
        "minTemp": "19°",
        "maxTemp": "30°",
      },
    ];
    listNotification.value = [
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
      'Machine 1: The percentage of CO gas exceeds the allowable level',
    ];
    super.onInit();
  }
}
