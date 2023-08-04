import 'package:cariera/models/language_model.dart';
import 'package:cariera/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController {
  //
  SharedPreferences sharedPreferences;
  AppController({required this.sharedPreferences}) {
    loadCurrentLanguage();
  }

  Locale _locale = const Locale('en', 'US');
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  List<LanguageModel> get languages => _languages;

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  List<LanguageModel> staticLanguages = [
    LanguageModel(
        flag: 'US',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
      flag: 'SA',
      languageName: 'عربى',
      countryCode: 'SA',
      languageCode: 'ar',
    ),
    LanguageModel(
      flag: 'IN',
      languageName: 'हिंदी',
      countryCode: 'IN',
      languageCode: 'hi',
    ),
    LanguageModel(
        flag: 'BD',
        languageName: 'বাংলা',
        countryCode: 'BGD',
        languageCode: 'bn'),
    // LanguageModel(
    //   flag: '🇵🇰',
    //   languageName: 'اردو',
    //   countryCode: 'URD',
    //   languageCode: 'ur',
    // ),
    LanguageModel(
      flag: 'MR',
      languageName: 'मराठी',
      countryCode: 'MAR',
      languageCode: 'mr',
    ),
  ];

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(
        AppConstants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(
        AppConstants.COUNTRY_CODE, locale.countryCode ?? 'US');
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ??
            staticLanguages[0].languageCode,
        sharedPreferences.getString(AppConstants.COUNTRY_CODE) ??
            staticLanguages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < staticLanguages.length; index++) {
      if (staticLanguages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(staticLanguages);
    update();
  }

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    saveLanguage(_locale);
    update();
  }
}
