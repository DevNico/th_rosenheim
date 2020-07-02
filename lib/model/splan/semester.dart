import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/date_utils.dart';

part 'semester.g.dart';

@JsonSerializable()
class Semester extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'shortname')
  final String shortName;
  @JsonKey(name: 'startdate')
  final DateTime startDate;
  @JsonKey(name: 'enddate')
  final DateTime endDate;

  Semester({
    @required this.id,
    @required this.name,
    @required this.shortName,
    DateTime startDate,
    DateTime endDate,
  })  : startDate = startDate.weekday > DateTime.friday ? startDate.weekStart().add(Duration(days: 7)) : startDate,
        endDate = endDate.weekday > DateTime.friday ? endDate.weekStart().add(Duration(days: 5)) : endDate;

  int get weekDays => startDate.differenceInDaysWithoutWeekends(endDate);

  factory Semester.fromJson(Map<String, dynamic> json) => _$SemesterFromJson(json);

  Map<String, dynamic> toJson() => _$SemesterToJson(this);

  @override
  List<Object> get props => [id, name, shortName, startDate, endDate];

  @override
  String toString() =>
      'Semester { id: $id, name: $name, shortName: $shortName, startDate: $startDate, endDate: $endDate }';
}
