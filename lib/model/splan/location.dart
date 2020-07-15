import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final int id;
  final String name;
  @JsonKey(name: 'shortname')
  final String shortName;

  Location({
    this.id,
    this.name,
    this.shortName,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  List<Object> get props => [id, name, shortName];

  @override
  String toString() => '''Location {
    id: $id,
    name: $name,
    shortName: $shortName,
  }''';
}
