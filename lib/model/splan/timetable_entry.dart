import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum EntryType {
  weekly,
  biweekly,
  everyThreeWeeks,
  everyFourWeeks,
  single,
  holiday,
  exam
}

class TimetableEntry extends Equatable {
  final String lectureName;
  final String lectureShortName;
  final String lectureExtra;
  final String lecturerName;
  final String lecturerShortName;
  final String planningGroup;
  final Duration startTime;
  final Duration endTime;
  final String room;
  final EntryType entryType;

  TimetableEntry({
    @required this.lectureName,
    @required this.lectureShortName,
    @required this.lectureExtra,
    @required this.lecturerName,
    @required this.lecturerShortName,
    @required this.planningGroup,
    this.startTime,
    this.endTime,
    @required this.room,
    @required this.entryType,
  });

  String detailsText({
    @required bool short,
  }) =>
      '${room != '' ? '$room | ' : ''}'
      '${short ? lecturerShortName : lecturerName}';

  @override
  List<Object> get props => [
        lectureName,
        lectureShortName,
        lectureExtra,
        lecturerName,
        lecturerShortName,
        planningGroup,
        startTime,
        endTime,
        room,
        entryType,
      ];

  @override
  String toString() {
    return '''TimetableEntry {
      lectureName: $lectureName,
      lectureShortName: $lectureShortName,
      lectureSubgroup: $lectureExtra,
      lecturerName: $lecturerName,
      lecturerShortName: $lecturerShortName,
      planningGroup: $planningGroup,
      startTime: $startTime,
      endTime: $endTime,
      room: $room,
      entryType: $entryType
    }''';
  }
}
