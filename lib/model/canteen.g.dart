// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canteen.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CanteenWeek _$CanteenWeekFromJson(Map<String, dynamic> json) {
  return CanteenWeek(
    number: json['number'] as int,
    year: json['year'] as int,
    days: (json['days'] as List)
        ?.map((e) =>
            e == null ? null : CanteenDay.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CanteenWeekToJson(CanteenWeek instance) =>
    <String, dynamic>{
      'number': instance.number,
      'year': instance.year,
      'days': instance.days,
    };

CanteenDay _$CanteenDayFromJson(Map<String, dynamic> json) {
  return CanteenDay(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    dishes: (json['dishes'] as List)
        ?.map((e) =>
            e == null ? null : CanteenMeal.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CanteenDayToJson(CanteenDay instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'dishes': instance.dishes,
    };

CanteenMeal _$CanteenMealFromJson(Map<String, dynamic> json) {
  return CanteenMeal(
    name: json['name'] as String,
    ingredients:
        (json['ingredients'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$CanteenMealToJson(CanteenMeal instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ingredients': instance.ingredients,
    };
