import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/settings/settings_bloc.dart';
import '../../locale/translation.dart';

class LanguageSettings extends StatefulWidget {
  LanguageSettings({Key key}) : super(key: key);

  @override
  _LanguageSettingsState createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ThTranslations.of(context).settingsLanguageTitle),
      ),
      body: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) => ListView(
          children: <Widget>[
            RadioListTile(
              title: Text('Deutsch'),
              value: 'de',
              onChanged: (loc) {
                BlocProvider.of<SettingsBloc>(context).add(Settings(locale: loc));
              },
              groupValue: settings.locale,
            ),
            RadioListTile(
              title: Text('English'),
              value: 'en',
              onChanged: (loc) {
                BlocProvider.of<SettingsBloc>(context).add(Settings(locale: loc));
              },
              groupValue: settings.locale,
            )
          ],
        ),
      ),
    );
  }
}
