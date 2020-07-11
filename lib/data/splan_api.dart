import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' show parse;
import 'package:intl/intl.dart';

import '../logger.dart';
import '../model/splan/model.dart';
import '../model/splan/timetable_entry.dart';
import '../utils/json_util.dart';
import 'base_api.dart';

export '../model/splan/model.dart';

class SplanApi extends BaseApi {
  static final SplanApi _instance = SplanApi._();

  SplanApi._()
      : super(
          baseUrl: 'https://splan.fh-rosenheim.de/splan/json',
          cacheDbName: 'splan_cache',
          defaultMaxAge: Duration(hours: 12),
          defaultMaxStale: Duration(days: 7),
        );

  factory SplanApi() {
    return _instance;
  }

  Future<List<Location>> getLocations() async {
    try {
      final response = await dio.get(
        '',
        queryParameters: {'m': 'getlocs'},
      );
      final json = await parseJsonInBackground(latin1.decode(response.data));
      return (json[0] as List).map((element) => Location.fromJson(element)).toList();
    } on Exception catch (error, stacktrace) {
      logger.e('Error getting Locations from SplanApi.', error, stacktrace);
      return null;
    }
  }

  Future<List<Semester>> getSemesters() async {
    try {
      final response = await dio.get(
        '',
        queryParameters: {
          'm': 'getpus',
        },
      );
      final json = await parseJsonInBackground(latin1.decode(response.data));
      return (json[0] as List).map((element) => Semester.fromJson(element)).toList();
    } on Exception catch (error, stacktrace) {
      logger.e('Error getting Semesters from SplanApi.', error, stacktrace);
      return null;
    }
  }

  Future<List<Course>> getCoursesForSemester(Semester semester) async {
    try {
      final response = await dio.get(
        '',
        queryParameters: {
          'm': 'getogs',
          'pu': semester.id,
        },
      );
      final json = await parseJsonInBackground(latin1.decode(response.data));
      return (json[0] as List).map((element) => Course.fromJson(element)).toList();
    } on Exception catch (error, stacktrace) {
      logger.e('Error getting Courses from SplanApi.', error, stacktrace);
      return null;
    }
  }

  Future<List<PlanningGroup>> getPlanningGroupsForSemesterAndCourse({
    @required Semester semester,
    @required Course course,
  }) async {
    try {
      final response = await dio.get(
        '',
        queryParameters: {
          'm': 'getPgsExt',
          'pu': semester.id,
          'og': course.id,
        },
      );
      final json = await parseJsonInBackground(latin1.decode(response.data));
      return (json[0] as List).map((element) => PlanningGroup.fromJson(element)).toList();
    } on Exception catch (error, stacktrace) {
      logger.e('Error getting CourseGroups from SplanApi.', error, stacktrace);
      return null;
    }
  }

  Future<Map<int, List<TimetableEntry>>> getTimetableWeek({
    @required Semester semester,
    @required Location location,
    @required List<Lecture> lectures,
    @required DateTime weekStart,
    bool onlyExams = false,
  }) async {
    try {
      lectures.sort((a, b) => a.id - b.id);

      final response = await dio.get(
        '',
        queryParameters: {
          'm': 'getTT',
          'sel': 'mt',
          'pu': semester.id,
          'lc': _compressIdsForURLParam(lectures.map((e) => e.id).toList()),
          'pgsc': _compressIdsForURLParam(lectures.map((e) => e.pgid).toList()),
          'oex': onlyExams,
          'dfc': DateFormat('yyyy-MM-dd').format(weekStart),
          'loc': location.id,
          'cb': 'o'
        },
      );

      final timetable = <int, List<TimetableEntry>>{};

      for (var day = 0; day < 5; day++) {
        timetable[day] = [];
      }

      final document = parse(latin1.decode(response.data));
      final elements = document.querySelectorAll('.ttevent');

      for (final element in elements) {
        var entryType;
        if (element.classes.contains('weeklyg')) {
          entryType = EntryType.weekly;
        } else if (element.classes.contains('twoweeklyg')) {
          entryType = EntryType.biweekly;
        } else if (element.classes.contains('threeweeklyg')) {
          entryType = EntryType.everyThreeWeeks;
        } else if (element.classes.contains('fourweeklyg')) {
          entryType = EntryType.everyFourWeeks;
        } else if (element.classes.contains('singleg')) {
          entryType = EntryType.single;
        } else if (element.classes.contains('holidayg')) {
          entryType = EntryType.holiday;
        } else if (element.classes.contains('examg')) {
          entryType = EntryType.exam;
        }

        final tooltip = element.querySelector('.tooltip');
        final tooltipStrings = tooltip.innerHtml.split('<br>');

        final leftString = RegExp(r'left:(-?\d+)px').firstMatch(element.attributes['style']).group(1);
        final left = int.parse(leftString);
        var day;
        if (left >= -1 && left < 179) {
          day = 0;
        } else if (left >= 179 && left < 359) {
          day = 1;
        } else if (left >= 359 && left < 539) {
          day = 2;
        } else if (left >= 539 && left < 739) {
          day = 3;
        } else if (left >= 739 && left < 939) {
          day = 4;
        } else {
          // Skip for Saturday and Sunday
          continue;
        }

        element.children.removeAt(0);
        element.children.removeLast();

        final elementStrings = element.innerHtml.split('<br>');

        final lectureSubgroup = elementStrings.length > 3 && elementStrings[4].startsWith('<span')
            ? elementStrings[4].replaceAll(RegExp('<[^>]*>'), '')
            : '';

        // Time
        final timeStringRegExpMatch = RegExp(r'(\d\d:\d\d)-(\d\d:\d\d)').firstMatch(element.innerHtml);
        var startTime, endTime;
        if (timeStringRegExpMatch != null) {
          final startTimeParts = timeStringRegExpMatch.group(1).split(':');
          startTime = Duration(hours: int.parse(startTimeParts[0]), minutes: int.parse(startTimeParts[1]));
          final endTimeParts = timeStringRegExpMatch.group(2).split(':');
          endTime = Duration(hours: int.parse(endTimeParts[0]), minutes: int.parse(endTimeParts[1]));
        }

        final room = tooltipStrings[3] == '${timeStringRegExpMatch.group(1)}-${timeStringRegExpMatch.group(2)}'
            ? ''
            : tooltipStrings[3];

        final lectureShortName = elementStrings[0] == room
            ? elementStrings[1].replaceAll(RegExp('<sup>.*<\/sup>'), '')
            : elementStrings[0].replaceAll(RegExp('<sup>.*<\/sup>'), '');

        final lecturerShortName = elementStrings[0] == room ? elementStrings[2] : elementStrings[1];

        var timetableEntry;
        if (entryType != EntryType.holiday) {
          timetableEntry = TimetableEntry(
            lectureName: tooltipStrings[0],
            lectureShortName: lectureShortName,
            lectureExtra: lectureSubgroup,
            lecturerName: tooltipStrings[1],
            lecturerShortName: lecturerShortName,
            planningGroup: tooltipStrings[2],
            startTime: startTime,
            endTime: endTime,
            room: room,
            entryType: entryType,
          );
        } else {
          timetableEntry = TimetableEntry(
            lectureName: tooltipStrings[0],
            lectureShortName: '',
            lectureExtra: elementStrings[0].replaceAll(tooltipStrings[1], '').trim(),
            lecturerName: '',
            lecturerShortName: '',
            planningGroup: '',
            room: '',
            entryType: entryType,
          );
        }

        if (tooltipStrings[0] == 'Englisch') {
          logger.d(tooltipStrings);
          logger.d(elementStrings);
          logger.d(timetableEntry);
        }

        timetable[day].add(timetableEntry);
      }

      return timetable;
    } on Exception catch (error, stacktrace) {
      logger.e('Error getting Timetable from SplanApi.', error, stacktrace);
      return null;
    }
  }

  String _compressIdsForURLParam(List<int> ids) {
    final encodingChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*.'.split('');
    var res = '';

    var first = _adjustValueWithNull(ids[0]);
    res += first >= 0 ? ',' : '|';
    if (first < 0) {
      first = -first;
    }

    while (first != 0) {
      res += encodingChars[first % 64];
      first = (first / 64).floor();
    }

    for (var i = 1; i < ids.length; i++) {
      var diff = _adjustValueWithNull(ids[i]) - _adjustValueWithNull(ids[i - 1]);
      res += diff >= 0 ? ',' : '|';
      if (diff < 0) {
        diff = -diff;
      }
      res += encodingChars[diff % 64];
      diff = (diff / 64).floor();

      while (diff != 0) {
        res += encodingChars[diff % 64];
        diff = (diff / 64).floor();
      }
    }
    return res;
  }

  int _adjustValueWithNull(int v) {
    if (v == null) {
      return 0;
    } else if (v >= 0) {
      return v + 1;
    } else {
      return v;
    }
  }
}
