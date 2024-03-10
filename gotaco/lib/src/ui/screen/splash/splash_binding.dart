import 'package:get/get.dart';
import 'package:gotaco/src/ui/screen/splash/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
