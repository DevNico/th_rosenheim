import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../model/splan/timetable_entry.dart';
import '../../utils/date_utils.dart';
import 'rounded_container.dart';
import 'timetable_entry_details.dart';

class TimetableEntryListTile extends StatelessWidget {
  final DateTime selectedDate;
  final List<TimetableEntry> entries;

  TimetableEntryListTile({
    @required this.selectedDate,
    @required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    if (entries.first.entryType == EntryType.holiday) {
      return RoundedContainer(
        width: size.width - 40,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              entries.first.lectureName,
              style: theme.primaryTextTheme.subtitle1.copyWith(fontWeight: FontWeight.w500, fontSize: 15),
            ),
            SizedBox(height: 2),
            AutoSizeText(
              '${entries.first.lectureExtra}',
              maxLines: 1,
              style: theme.primaryTextTheme.subtitle1.copyWith(fontSize: 15),
            ),
          ],
        ),
      );
    }

    final isDone = selectedDate.withoutTime().add(entries.first.endTime).isBefore(DateTime.now());

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: TimetableEventDetails(selectedDate: selectedDate, entries: entries),
            );
          },
        );
      }, // _handleTap,
      child: RoundedContainer(
        border: isDone ? null : Border.all(color: theme.accentColor, width: 1),
        width: size.width - 40,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      '${entries.first.startTime.stringify()}',
                      style: theme.primaryTextTheme.bodyText1.copyWith(
                        fontFamily: 'RobotoMono',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${entries.first.endTime.stringify()}',
                      style: theme.primaryTextTheme.bodyText1.copyWith(
                        fontFamily: 'RobotoMono',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 8),
                SizedBox(
                  height: 36,
                  width: 1,
                  child: Container(
                    width: 1,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: theme.dividerColor,
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      for (final event in entries)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: entries.indexOf(event) < entries.length ? 6 : 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                AutoSizeText(
                                  entries.length > 1 ? event.lectureShortName : event.lectureName,
                                  maxLines: 1,
                                  style: theme.primaryTextTheme.bodyText1
                                      .copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                                ),
                                SizedBox(height: 2),
                                AutoSizeText(
                                  '${event.room != '' ? '${event.room} | ' : ''}${entries.length > 1 ? event.lecturerShortName : event.lecturerName}',
                                  maxLines: 1,
                                  style: theme.primaryTextTheme.bodyText1.copyWith(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
