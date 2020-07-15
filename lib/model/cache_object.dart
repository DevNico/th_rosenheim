import 'package:json_annotation/json_annotation.dart';

part 'cache_object.g.dart';

@JsonSerializable()
class CacheObject {
  final DateTime dateTimeLoaded;
  final dynamic data;

  CacheObject(this.data) : dateTimeLoaded = DateTime.now();

  Map<String, dynamic> toJson() => _$CacheObjectToJson(this);

  factory CacheObject.fromJson(Map<String, dynamic> json) =>
      _$CacheObjectFromJson(json);
}
