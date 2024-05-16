import 'dart:convert';

import 'package:get/get.dart';
import 'package:gotaco/src/data/model/iot_model.dart';
import 'package:gotaco/src/data/provider/socket_constants.dart';
import 'package:gotaco/src/ui/app/app_controller.dart';
import 'package:gotaco/src/ui/screen/home/home_controller.dart';
import 'package:gotaco/src/util/app_utils.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

import '../../res/string/app_string.dart';
import '../../util/app_log.dart';

class SocketService {
  SocketService._();

  static StompClient? stompClient;

  static void connectStompClient() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url:
            'http://${SocketConstants.ipAddressSocket}:${SocketConstants.postSocket}/ws',
        onConnect: onStompConnect,
        onWebSocketError: (dynamic error) {
          AppLog.error(error);
          SocketConstants.isConnectSuccessful.value = false;
        },
      ),
    );

    try {
      stompClient!.activate();
      SocketConstants.isConnectSuccessful.value = true;
    } catch (e) {
      AppLog.error("Error active socket: ${e.toString()}");
      showToast(StringConstants.errorActiveSocket.tr);
      SocketConstants.isConnectSuccessful.value = false;
    }
  }

  static void onStompConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/topic/messages',
      callback: (StompFrame frame) {
        try {
          Get.find<AppController>().data.value =
              IotModel.fromJson(jsonDecode(frame.body ?? ""));
        } catch (e) {
          AppLog.error(e);
          Get.find<AppController>().data.value =
              IotModel(humidity: null, temperature: null, rsR0: null);
          if (Get.isRegistered<HomeController>()) {
            Get.find<HomeController>().listDataCO.add(
                  Get.find<AppController>()
                      .data
                      .value
                      .rsR0
                      ?.results
                      .last
                      .series
                      .last
                      .values
                      .last
                      .last,
                );
          }
        }
      },
    );
  }
}
