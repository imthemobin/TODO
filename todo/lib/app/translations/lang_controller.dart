import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LangsController extends GetxController {
  void changeLanguage(String languageCode, String countryCode) {
    var local = Locale(languageCode, countryCode);
    Get.updateLocale(local);
  }

}
