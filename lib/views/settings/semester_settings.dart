import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/settings/settings_bloc.dart';
import '../../data/splan_api.dart';

class SemesterSettings extends StatefulWidget {
  SemesterSettings({Key key}) : super(key: key);

  @override
  _SemesterSettingsState createState() => _SemesterSettingsState();
}

class _SemesterSettingsState extends State<SemesterSettings> {
  bool initialized = false;
  List<Semester> semesters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Semester'),
      ),
      body: BlocBuilder<SettingsBloc, Settings>(
        builder: (context, settings) {
          if (settings.initialized) {
            // Load semesters on first render
            if (!initialized) {
              SplanApi().getSemesters().then((value) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  setState(() {
                    initialized = true;
                    semesters = value;
                  });
                });
              });
            }

            if (initialized) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                itemCount: semesters.length,
                itemBuilder: (context, index) {
                  final semester = semesters[index];

                  return Card(
                    child: RadioListTile(
                      title: Text('${semester.name} (${semester.shortName})'),
                      groupValue: settings.semester,
                      value: semester,
                      onChanged: (semester) {
                        BlocProvider.of<SettingsBloc>(context).add(settings.merge(Settings(
                          semester: semester,
                          course: null,
                          lectures: [],
                        )));
                      },
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
