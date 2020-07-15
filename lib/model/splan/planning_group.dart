import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

import 'lecture.dart';

part 'planning_group.g.dart';

@JsonSerializable()
class PlanningGroup extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'shortname')
  final String shortName;
  final List<Lecture> lectures;

  PlanningGroup({
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.lectures,
  });

  factory PlanningGroup.fromJson(Map<String, dynamic> json) =>
      _$PlanningGroupFromJson(json);

  Map<String, dynamic> toJson() => _$PlanningGroupToJson(this);

  @override
  List<Object> get props => [id, name, shortName];

  @override
  String toString() {
    return '''PlanningGroup {
      id: $id,
      name: $name,
      shortName: $shortName,
      lectures: $lectures
    }''';
  }
}
