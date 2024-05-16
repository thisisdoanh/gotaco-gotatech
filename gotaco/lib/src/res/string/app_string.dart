import 'package:get/get.dart';
import 'package:gotaco/src/res/string/vi_strings.dart';

import 'en_strings.dart';

class AppString extends Translations {
  static const String localeCodeVi = 'vi_VN';
  static const String localeCodeEn = 'en_US';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viStrings,
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    Map<String, String> selectedLanguage =
        Get.locale.toString() == localeCodeEn ? enStrings : viStrings;
    String text = key;
    if (selectedLanguage.containsKey(key) && selectedLanguage[key] != null) {
      text = selectedLanguage[key] ?? key;
    }
    return text;
  }
}

class StringConstants {
  static String gotaco = "gotaco";
  static String day = "Day";
  static String co2Gas = "CO2Gas";
  static String ancol = "ancol";
  static String welcome = "welcome";
  static String listMachine = "listMachine";
  static String notification = "notification";
  static String errorActiveSocket = "errorActiveSocket";
}
