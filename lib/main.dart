import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'blocs/bloc_observer.dart';
import 'blocs/canteen/canteen_bloc.dart';
import 'blocs/settings/settings_bloc.dart';
import 'blocs/timetable/timetable_bloc.dart';
import 'locale/translation_delegate.dart';
import 'theme.dart';
import 'views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Locale
  // Intl.defaultLocale = 'de_DE';
  // await initializeDateFormatting('de_DE', null);

  // Bloc logging
  Bloc.observer = SimpleBlocObserver();

  //await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(THRosenheimApp());
}

class THRosenheimApp extends StatefulWidget {
  static List<String> supportedLocales = ['en', 'de'];

  @override
  _THRosenheimAppState createState() => _THRosenheimAppState();
}

class _THRosenheimAppState extends State<THRosenheimApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(lazy: false, create: (context) => SettingsBloc()),
        BlocProvider(lazy: false, create: (context) => TimetableBloc()),
        BlocProvider(lazy: false, create: (context) => CanteenBloc()),
      ],
      child: BlocBuilder<SettingsBloc, Settings>(
        buildWhen: (previous, current) => previous.themeMode != current.themeMode || previous.locale != current.locale,
        builder: (context, settings) {
          if (!settings.initialized) {
            return Container(color: kDark);
          }

          return MaterialApp(
            title: 'TH Rosenheim',
            localizationsDelegates: [
              TranslationDelegate(newLocale: Locale(settings.locale, '')),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: THRosenheimApp.supportedLocales.map((l) => Locale(l, '')).toList(),
            themeMode: settings.themeMode,
            theme: theme,
            darkTheme: darkTheme,
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
