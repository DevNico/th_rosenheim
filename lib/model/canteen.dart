import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'canteen.g.dart';

const additiveList = [
  'Ei',
  'En',
  'Fi',
  'Gl',
  'GlW',
  'GlR',
  'GlG',
  'GlH',
  'GlD',
  'Kn',
  'Kr',
  'Lu',
  'Mi',
  'Sc',
  'ScM',
  'ScH',
  'ScW',
  'ScC',
  'ScP',
  'Se',
  'Sf',
  'Sl',
  'So',
  'Sw',
  'Wt',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '13',
  '14',
  '99',
];

@JsonSerializable()
class CanteenWeek {
  final int number;
  final int year;
  final List<CanteenDay> days;

  CanteenWeek({
    @required this.number,
    @required this.year,
    @required this.days,
  });

  Map<String, dynamic> toJson() => _$CanteenWeekToJson(this);

  factory CanteenWeek.fromJson(Map<String, dynamic> json) => _$CanteenWeekFromJson(json);
}

@JsonSerializable()
class CanteenDay {
  final DateTime date;
  final List<CanteenMeal> dishes;

  CanteenDay({
    @required this.date,
    @required this.dishes,
  });

  Map<String, dynamic> toJson() => _$CanteenDayToJson(this);

  factory CanteenDay.fromJson(Map<String, dynamic> json) => _$CanteenDayFromJson(json);
}

enum CanteenMealType { vegan, vegetarian, beef, pig, chicken }

@JsonSerializable()
class CanteenMeal {
  final String name;
  final List<String> ingredients;

  @JsonKey(ignore: true)
  CanteenMealType type;

  @JsonKey(ignore: true)
  List<String> additives;

  CanteenMeal({
    @required this.name,
    @required this.ingredients,
  }) {
    if (name.contains(RegExp(r'(Huhn)|(Hähn)|(Hahn)|(Hühn)|(Pute)'))) {
      type = CanteenMealType.chicken;
    }
    if (ingredients.contains('vegan')) {
      type = CanteenMealType.vegan;
      ingredients.remove('vegan');
    }
    if (ingredients.contains('vegetarisch')) {
      type = CanteenMealType.vegetarian;
      ingredients.remove('vegetarisch');
    }
    if (ingredients.contains('R')) {
      type = CanteenMealType.beef;
      ingredients.remove('R');
    }
    if (ingredients.contains('S')) {
      type = CanteenMealType.pig;
      ingredients.remove('S');
    }

    ingredients.sort();

    additives = [];
    for (final ingredient in ingredients) {
      if (ingredient.length == 3 && additives.contains(ingredient.substring(0, 2))) {
        if (!additives.contains(ingredient.substring(0, 2))) {
          additives.add(ingredient.substring(0, 2));
        }
      } else {
        additives.add(ingredient);
      }
    }
    additives.sort();
    additives = additives.reversed.toList();
  }

  String get typeAssetString =>
      'assets/additives/${type.toString().toLowerCase().replaceAll('canteenmealtype.', '')}.png';

  Map<String, dynamic> toJson() => _$CanteenMealToJson(this);

  factory CanteenMeal.fromJson(Map<String, dynamic> json) => _$CanteenMealFromJson(json);
}
