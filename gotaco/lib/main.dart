import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/data/service/socket_service.dart';

import 'src/res/string/app_string.dart';
import 'src/ui/app/app_binding.dart';
import 'src/ui/router/app_page.dart';
import 'src/ui/router/app_router.dart';
import 'src/ui/theme/app_color.dart';
import 'src/util/app_constrant.dart';

void main() {
  SocketService.connectStompClient();
  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, widget) {
          final data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaler: TextScaler.noScaling),
            child: GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialBinding: AppBinding(),
              initialRoute: AppRouter.splashScreen,
              defaultTransition: Transition.fade,
              getPages: AppPage.pages,
              supportedLocales: AppConstant.availableLocales,
              locale: AppConstant.availableLocales[1],
              fallbackLocale: AppConstant.availableLocales[0],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              translations: AppString(),
              theme: ThemeData(
                primaryColor: AppColor.primaryColor,
                fontFamily: 'Nunito',
                textSelectionTheme: const TextSelectionThemeData(
                  selectionHandleColor: Colors.transparent,
                ),
              ),
            ),
          );
        }),
  );
}
