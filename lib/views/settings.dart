import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/settings/settings_bloc.dart';
import '../locale/translation.dart';
import '../theme.dart';
import 'settings/course_of_studies_settings.dart';
import 'settings/language_settings.dart';
import 'settings/lecture_settings.dart';
import 'settings/semester_settings.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ThTranslations.of(context).settings),
        shape: kAppBarShape,
      ),
      body: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) => ListView(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          children: <Widget>[
            _SettingsTitle(
              title: ThTranslations.of(context).settingsCategoryGeneral,
            ),
            _SettingsButton(
              title: ThTranslations.of(context).settingsDarkThemeTitle,
              subtitle: ThTranslations.of(context).settingsDarkThemeDescription,
              value: settings.themeMode == ThemeMode.dark,
              onChanged: (value) => BlocProvider.of<SettingsBloc>(context).add(
                Settings(themeMode: value ? ThemeMode.dark : ThemeMode.light),
              ),
            ),
            _SettingsSpacer(),
            _SettingsLink(
              title: ThTranslations.of(context).settingsLanguageTitle,
              subtitle: ThTranslations.of(context).settingsLanguageDescription,
              builder: (context) => LanguageSettings(),
            ),
            _SettingsSpacer(),
            _SettingsTitle(
              title: ThTranslations.of(context).settingsCategoryTimetable,
            ),
            _SettingsLink(
              title: ThTranslations.of(context).settingsSemesterTitle,
              subtitle: ThTranslations.of(context).settingsSemesterDescription,
              builder: (context) => SemesterSettings(),
            ),
            _SettingsSpacer(),
            _SettingsLink(
              title: ThTranslations.of(context).settingsCourseTitle,
              subtitle: ThTranslations.of(context).settingsCourseDescription,
              builder: (context) => CourseOfStudiesSettings(),
            ),
            _SettingsSpacer(),
            _SettingsLink(
              title: ThTranslations.of(context).settingsLecturesTitle,
              subtitle: ThTranslations.of(context).settingsLecturesDescription,
              builder: (context) => LectureSettings(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsSpacer extends StatelessWidget {
  const _SettingsSpacer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 8);
  }
}

class _SettingsTitle extends StatelessWidget {
  final String title;

  const _SettingsTitle({
    Key key,
    @required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(6, 8, 6, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}

class _SettingsLink extends StatelessWidget {
  final String title;
  final String subtitle;
  final WidgetBuilder builder;

  const _SettingsLink({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.chevron_right),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: builder)),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsButton({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
