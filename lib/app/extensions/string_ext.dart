import 'package:flutter/material.dart';

import '../data/app_language_data.dart';
import '../data/models/language.dart';

extension ValidationExtension on String {
  bool get isValidName => length > 0;
  bool get isValidPassword => length > 7;
  bool get isValidMobile => (length == 11 || length == 14);
}

extension Languageparsing on String {
  Language? getLanguageFromCode() {
    if (isEmpty) return null;
    try {
      var lang = appLanguages
          .firstWhere((e) => e.code!.toLowerCase() == toLowerCase());
      return lang;
    } catch (e) {
      return null;
    }
  }

  Locale? getLocaleFromCode() {
    if (isEmpty) return null;
    try {
      var locale =
          appLocales.firstWhere((e) => e.languageCode == toLowerCase());
      return locale;
    } catch (e) {
      return null;
    }
  }
}
