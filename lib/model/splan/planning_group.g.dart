// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planning_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanningGroup _$PlanningGroupFromJson(Map<String, dynamic> json) {
  return PlanningGroup(
    id: json['id'] as int,
    name: json['name'] as String,
    shortName: json['shortname'] as String,
    lectures: (json['lectures'] as List)
        ?.map((e) =>
            e == null ? null : Lecture.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$PlanningGroupToJson(PlanningGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'shortname': instance.shortName,
      'lectures': instance.lectures,
    };
