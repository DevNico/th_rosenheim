import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'timetable_entry.dart';

class TimetableWeek extends Equatable {
  final List<TimetableEntry> entries;
  final DateTime lastUpdated;

  TimetableWeek({
    @required this.entries,
    @required this.lastUpdated,
  });

  @override
  List<Object> get props => [entries, lastUpdated];

  @override
  String toString() {
    return '''TimetableWeek {
      entries: $entries,
      lastUpdated: $lastUpdated
    }''';
  }
}
