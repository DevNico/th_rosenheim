import 'dart:math';

import 'package:flutter/material.dart';

import '../../model/splan/timetable_entry.dart';
import '../timetable/timetable_empty.dart';
import 'rounded_container.dart';
import 'timetable_entry_list_tile.dart';

class TimetableWidget extends StatelessWidget {
  final DateTime selectedDate;
  final List<TimetableEntry> timetableEntries;

  const TimetableWidget({
    Key key,
    @required this.selectedDate,
    @required this.timetableEntries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (timetableEntries == null) {
      return RoundedContainer(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (timetableEntries.isEmpty) {
      return TimetableNoLectures();
    }

    var combinedEntries = <List<TimetableEntry>>[];
    var currentEntries = <TimetableEntry>[];

    var lastTime;
    for (final entry in timetableEntries) {
      if (entry.startTime == null || lastTime != entry.startTime) {
        if (lastTime != null) {
          combinedEntries.add(currentEntries);
          currentEntries = <TimetableEntry>[];
        }
        lastTime = entry.startTime;
      }

      currentEntries.add(entry);
    }

    if (currentEntries != null && !currentEntries.isEmpty) {
      combinedEntries.add(currentEntries);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: max(combinedEntries.length, 1),
      itemBuilder: (context, index) {
        return TimetableEntryListTile(
          selectedDate: selectedDate,
          entries: combinedEntries[index],
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12),
    );
  }
}
