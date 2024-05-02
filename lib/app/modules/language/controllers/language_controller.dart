import 'package:flutter/material.dart';
import 'package:lifelink/app/extensions/string_ext.dart';
import 'package:super_ui_kit/super_ui_kit.dart';

import '../../../data/app_language_data.dart';
import '../../../data/models/language.dart';
import '../../../util/app_constants.dart';
import '../../setting/controllers/setting_controller.dart';

class LanguageController extends GetxController {
  final languages = <Language>[].obs;
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getSupportedLnaguages();
  }

  void changeLanguage(Language lang) {
    if (lang.code == null || lang.code == Get.locale?.languageCode) {
      return;
    }
    try {
      var locale = Locale(lang.code!, "");
      Get.updateLocale(locale);
      box.write(kCurrentLangCode, lang.code ?? appLanguages.first.id);
      SettingController settingController = Get.find();
      settingController.currentLang?.value = lang.code!.getLanguageFromCode();
    } catch (e) {
      e.printError();
    }
  }

  void getSupportedLnaguages() {
    languages.value = appLanguages;
  }
}
