import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'splan/model.dart';

part 'settings.g.dart';

@JsonSerializable()
class Settings extends Equatable {
  // Splan
  final Semester semester;
  final Course course;
  final List<Lecture> lectures;
  // Other
  final String locale;
  final ThemeMode themeMode;
  @JsonKey(ignore: true)
  final bool initialized;

  Settings({
    this.semester,
    this.course,
    this.lectures,
    this.locale,
    this.themeMode,
    this.initialized = true,
  });

  Settings merge(Settings other) => Settings(
        semester: other.semester ?? semester,
        course: other.course ?? course,
        lectures: other.lectures ?? lectures,
        locale: other.locale ?? locale,
        themeMode: other.themeMode ?? themeMode,
        initialized: other.initialized ?? initialized,
      );

  Map<String, dynamic> toJson() => _$SettingsToJson(this);

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);

  @override
  List<Object> get props => [semester, course, ...(lectures ?? []), themeMode, locale, initialized];

  @override
  String toString() => '''Settings {
    semester: $semester,
    course: $course,
    lectures: $lectures,
    locale: $locale,
    themeMode: $themeMode
  }''';
}
