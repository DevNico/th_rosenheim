// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'semester.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Semester _$SemesterFromJson(Map<String, dynamic> json) {
  return Semester(
    id: json['id'] as int,
    name: json['name'] as String,
    shortName: json['shortname'] as String,
    startDate: json['startdate'] == null
        ? null
        : DateTime.parse(json['startdate'] as String),
    endDate: json['enddate'] == null
        ? null
        : DateTime.parse(json['enddate'] as String),
  );
}

Map<String, dynamic> _$SemesterToJson(Semester instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortname': instance.shortName,
      'startdate': instance.startDate?.toIso8601String(),
      'enddate': instance.endDate?.toIso8601String(),
    };
