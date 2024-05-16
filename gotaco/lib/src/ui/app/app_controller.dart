import 'package:get/get.dart';
import 'package:gotaco/src/data/model/iot_model.dart';
import 'package:gotaco/src/util/app_log.dart';

class AppController extends SuperController {
  Rx<IotModel> data = IotModel(
    humidity: null,
    temperature: null,
    rsR0: null,
  ).obs;

  onPressSeeDetail() {
    AppLog.info(data);
    AppLog.info(data);
    AppLog.info(data);
  }

  @override
  void onDetached() {}

  @override
  void onHidden() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}
}
