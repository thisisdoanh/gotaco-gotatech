import 'package:get/get.dart';
import 'package:gotaco/src/ui/screen/home/home_binding.dart';
import 'package:gotaco/src/ui/screen/home/home_screen.dart';
import 'package:gotaco/src/ui/screen/splash/splash_binding.dart';
import 'package:gotaco/src/ui/screen/splash/splash_screen.dart';

import 'app_router.dart';

class AppPage {
  static final pages = [
    GetPage(
        name: AppRouter.splashScreen,
        page: () => const SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRouter.homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
  ];
}
