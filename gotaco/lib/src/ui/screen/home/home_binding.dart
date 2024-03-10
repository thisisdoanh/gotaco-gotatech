import 'package:get/get.dart';
import 'package:gotaco/src/ui/screen/home/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}