import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controllers/shared/local/shared_preferences_controller.dart';
import '../models/components/constants.dart';

class LanguageController extends GetxController {
  final _shared = SharedPreferencesController();

  Future<void> injectLanguage() async  {

  language = await _shared.getString(key: 'language') ?? 'Arabic';
}

  Locale getLanguage() {
    if (language == 'English') {
      return const Locale('en', 'US');
    } else {
      return const Locale('ar', 'AE');
    }
  }

  String getLanguageCode() {
    return language=='Arabic' ? 'ar' : 'en';
  }

  dynamic changeLanguage() {
    Get.locale == const Locale('ar', 'AE')
        ? {
            Get.updateLocale(const Locale('en', 'US')),
            _shared.setString(key: 'language', value: 'English'),
            update()
          }
        : {
            Get.updateLocale(const Locale('ar', 'AE')),
            _shared.setString(key: 'language', value: 'Arabic'),
            update()
          };
  }
}
