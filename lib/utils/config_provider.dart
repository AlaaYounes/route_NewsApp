import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  String language = 'en';

  changeLanguage(String newLanguage) {
    language = newLanguage;
    notifyListeners();
  }

  bool isEnglish() {
    return language == 'en' ? true : false;
  }
}
