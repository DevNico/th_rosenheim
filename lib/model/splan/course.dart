import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'shortname')
  final String shortName;

  Course({
    @required this.id,
    @required this.name,
    @required this.shortName,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);

  @override
  List<Object> get props => [id, name, shortName];

  @override
  String toString() => 'Course { id: $id, name: $name, shortName: $shortName }';
}
