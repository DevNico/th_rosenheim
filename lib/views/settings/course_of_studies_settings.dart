import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/settings/settings_bloc.dart';
import '../../data/splan_api.dart';
import '../../locale/translation.dart';
import 'semester_settings.dart';

class CourseOfStudiesSettings extends StatefulWidget {
  @override
  _CourseOfStudiesSettingsState createState() =>
      _CourseOfStudiesSettingsState();
}

class _CourseOfStudiesSettingsState extends State<CourseOfStudiesSettings> {
  bool initialized = false;
  List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ThTranslations.of(context).settingsCourseTitle),
      ),
      body: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) {
          if (settings.initialized) {
            if (settings.semester == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(ThTranslations.of(context)
                        .settingsSemesterNotConfigured),
                    RaisedButton(
                      child: Text(
                        ThTranslations.of(context)
                            .settingsSemesterNotConfiguredButton,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SemesterSettings(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }

            // Load courses on first render
            if (!initialized) {
              SplanApi().getCoursesForSemester(settings.semester).then((value) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    initialized = true;
                    courses = value;
                  });
                });
              });
            }

            if (initialized) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  final course = courses[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: RadioListTile(
                        title: Text(course.shortName),
                        subtitle: Text(course.name),
                        value: course,
                        groupValue: settings.course,
                        onChanged: (checked) {
                          BlocProvider.of<SettingsBloc>(context)
                              .add(settings.merge(Settings(
                            course: course,
                            lectures: [],
                          )));
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 4),
              );
            }
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
