import 'package:flutter/material.dart';

class AppLocalizationController extends ChangeNotifier {
  static String currentAppLanguage = "en";

  static const Map<String, dynamic> _data = {
    "header": {
      "en": "test",
      "ar": "مرحباً",
    },
  };

  String get appLanguage => currentAppLanguage;

  void changeLanguage(String newLanguage) {
    if (currentAppLanguage != newLanguage) {
      currentAppLanguage = newLanguage;
      notifyListeners();
    }
  }

  String getTextValue(String key) {
    return _data[key]?[currentAppLanguage] ?? "Something went wrong";
  }
}