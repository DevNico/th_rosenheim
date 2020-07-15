import 'dart:async';

import 'package:flutter/material.dart';

import '../main.dart';
import 'translation.dart';

class TranslationDelegate extends LocalizationsDelegate<ThTranslations> {
  final Locale newLocale;

  const TranslationDelegate({this.newLocale});

  @override
  bool isSupported(Locale locale) =>
      THRosenheimApp.supportedLocales.contains(locale.languageCode);

  @override
  Future<ThTranslations> load(Locale locale) =>
      ThTranslations.load(newLocale ?? locale);

  // TODO: Stop all text from flashing when the theme changes
  @override
  bool shouldReload(LocalizationsDelegate<ThTranslations> old) => true;
}
