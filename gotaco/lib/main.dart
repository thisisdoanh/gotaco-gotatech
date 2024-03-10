import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gotaco/src/util/app_constrant.dart';
import 'package:gotaco/src/res/string/app_string.dart';
import 'package:gotaco/src/ui/app/app_binding.dart';
import 'package:gotaco/src/ui/router/app_page.dart';
import 'package:gotaco/src/ui/router/app_router.dart';
import 'package:gotaco/src/ui/theme/app_color.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() async {
  final wsUrl = Uri.parse('wss://echo.websocket.in');
  final channel = WebSocketChannel.connect(wsUrl);

  await channel.ready;

  channel.stream.listen((message) {
    channel.sink.add('received!');
  });
  runApp(
    ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, widget) {
          final data = MediaQuery.of(context);
          return MediaQuery(
            data: data.copyWith(textScaleFactor: 1),
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
