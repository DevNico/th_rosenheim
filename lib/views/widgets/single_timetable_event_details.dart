import 'package:flutter/material.dart';

import '../../model/splan/timetable_entry.dart';

class SingleTimetableEventDetails extends StatelessWidget {
  final TimetableEntry entry;

  SingleTimetableEventDetails(this.entry);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Text(
            entry.lectureName,
            style: theme.primaryTextTheme.subtitle1
                .copyWith(fontSize: 17, fontWeight: FontWeight.w500),
          ),
        ),
        if (entry.room != '')
          _buildInfo(Icons.room, entry.room,
              theme.primaryTextTheme.subtitle1.copyWith(fontSize: 16)),
        if (entry.lectureExtra != '')
          _buildInfo(Icons.info, entry.lectureExtra,
              theme.primaryTextTheme.subtitle1.copyWith(fontSize: 16)),
        if (entry.lecturerName != '')
          _buildInfo(Icons.person, entry.lecturerName,
              theme.primaryTextTheme.subtitle1.copyWith(fontSize: 16)),
      ],
    );
  }

  _buildInfo(IconData icon, String content, TextStyle theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              content,
              style: theme,
            ),
          ),
        ],
      ),
    );
  }
}
