import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ThTranslations {
  Locale locale;
  static Map<dynamic, dynamic> _localisedValues;

  ThTranslations(this.locale) {
    _localisedValues = {};
  }

  static ThTranslations of(BuildContext context) {
    return Localizations.of<ThTranslations>(context, ThTranslations);
  }

  static Future<ThTranslations> load(Locale locale) async {
    final appTranslations = ThTranslations(locale);
    final jsonContent = await rootBundle
        .loadString('assets/locale/${locale.languageCode}.json');
    _localisedValues = json.decode(jsonContent);
    return appTranslations;
  }

  String get currentLanguage => locale.languageCode;

  // General
  String get dashboard => text('dashboard');
  String get map => text('map');
  String get settings => text('settings');

  String get timetable => text('timetable');
  String get canteen => text('canteen');

  // Canteen
  String get canteenNoData => text('canteen_no_data');
  String get canteenAllergenes => text('canteen_allergenes');
  String additive(String key) => text('canteen_additive_${key.toLowerCase()}');

  // Settings
  String get settingsTimetableNotConfigured =>
      text('settings_timetable_not_configured');
  String get settingsSemesterNotConfigured =>
      text('settings_semester_not_configured');
  String get settingsSemesterNotConfiguredButton =>
      text('settings_semester_not_configured_button');
  String get settingsCourseNotConfigured =>
      text('settings_course_not_configured');
  String get settingsCourseNotConfiguredButton =>
      text('settings_course_not_configured_button');
  String get settingsLecturesNotConfigured =>
      text('settings_lectures_not_configured');
  String get settingsLecturesNotConfiguredButton =>
      text('settings_lectures_not_configured_button');
  String get settingsCategoryGeneral => text('settings_category_general');
  String get settingsDarkThemeTitle => text('settings_dark_theme_title');
  String get settingsDarkThemeDescription =>
      text('settings_dark_theme_description');
  String get settingsLanguageTitle => text('settings_language_title');
  String get settingsLanguageDescription =>
      text('settings_language_description');
  String get settingsCategoryTimetable => text('settings_category_timetable');
  String get settingsSemesterTitle => text('settings_semester_title');
  String get settingsSemesterDescription =>
      text('settings_semester_description');
  String get settingsCourseTitle => text('settings_course_title');
  String get settingsCourseDescription => text('settings_course_description');
  String get settingsLecturesTitle => text('settings_lectures_title');
  String get settingsLecturesDescription =>
      text('settings_lectures_description');
  String get settingsLecturesMax => text('settings_lectures_max');
  String get settingsLecturesSelectAll => text('settings_lectures_select_all');
  String get settingsLecturesDeselectAll =>
      text('settings_lectures_deselect_all');
  String get settingsLicenseTitle => text('settings_license_title');
  String get settingsLicenseDescription => text('settings_license_description');

  String text(String key) => _localisedValues[key] ?? '';
}
