// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return Lecture(
    id: json['id'] as int,
    name: json['name'] as String,
    shortName: json['shortname'] as String,
    pgid: json['pgid'] as int,
  );
}

Map<String, dynamic> _$LectureToJson(Lecture instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortname': instance.shortName,
      'pgid': instance.pgid,
    };
