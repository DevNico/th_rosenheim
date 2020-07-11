import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/settings.dart';

export '../../model/settings.dart';

class SettingsBloc extends Bloc<Settings, Settings> {
  SettingsBloc() : super(Settings(initialized: false)) {
    _load().then(add);
  }

  @override
  Stream<Settings> mapEventToState(
    Settings event,
  ) async* {
    final settings = state.merge(event);
    // Don't await so the user isn't slowed down
    _save(settings);
    yield settings;
  }

  Future<Settings> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final settingsString = prefs.getString('settings');

    if (settingsString != null) {
      final json = jsonDecode(settingsString);
      return Settings.fromJson(json);
    } else {
      // Defaults
      final settings = Settings(
        locale: 'en',
        themeMode: ThemeMode.dark,
      );
      return settings;
    }
  }

  Future _save(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('settings', jsonEncode(settings.toJson()));
  }
}
