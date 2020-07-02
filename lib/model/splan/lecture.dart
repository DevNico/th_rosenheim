import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lecture.g.dart';

@JsonSerializable()
class Lecture extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'shortname')
  final String shortName;
  final int pgid;

  Lecture({
    @required this.id,
    @required this.name,
    @required this.shortName,
    @required this.pgid,
  });

  factory Lecture.fromJson(Map<String, dynamic> json) => _$LectureFromJson(json);

  Map<String, dynamic> toJson() => _$LectureToJson(this);

  @override
  List<Object> get props => [id, name, shortName, pgid];

  @override
  String toString() {
    return 'Lecture { id: $id, shortName: $shortName, pgid: $pgid }';
  }
}
