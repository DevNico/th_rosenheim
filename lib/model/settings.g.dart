// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Settings _$SettingsFromJson(Map<String, dynamic> json) {
  return Settings(
    semester: json['semester'] == null
        ? null
        : Semester.fromJson(json['semester'] as Map<String, dynamic>),
    course: json['course'] == null
        ? null
        : Course.fromJson(json['course'] as Map<String, dynamic>),
    lectures: (json['lectures'] as List)
        ?.map((e) =>
            e == null ? null : Lecture.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    locale: json['locale'] as String,
    themeMode: _$enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']),
  );
}

Map<String, dynamic> _$SettingsToJson(Settings instance) => <String, dynamic>{
      'semester': instance.semester,
      'course': instance.course,
      'lectures': instance.lectures,
      'locale': instance.locale,
      'themeMode': _$ThemeModeEnumMap[instance.themeMode],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
