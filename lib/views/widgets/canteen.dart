import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../locale/translation.dart';
import '../../model/canteen.dart';
import '../../utils/string_utils.dart';
import 'rounded_container.dart';

class CanteenWidget extends StatelessWidget {
  final List<CanteenMeal> meals;

  CanteenWidget({@required this.meals});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (meals != null && meals.length > 0) ...[
          ListView.separated(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: 3,
            itemBuilder: (context, index) => MealWidget(meals[index]),
            separatorBuilder: (context, index) => SizedBox(height: 16),
          ),
          StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            itemCount: meals.length - 3,
            staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            itemBuilder: (context, index) => MealWidget(meals[index + 3]),
          )
        ] else
          RoundedContainer(
            width: MediaQuery.of(context).size.width - 40,
            child: Column(
              children: <Widget>[
                Text(
                  ThTranslations.of(context).canteenNoData,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class MealWidget extends StatelessWidget {
  final CanteenMeal meal;

  MealWidget(this.meal);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: 150,
      child: Row(
        children: <Widget>[
          meal.type != null
              ? Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Image.asset(
                    meal.typeAssetString,
                    width: 38,
                  ),
                )
              : SizedBox(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  meal.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                meal.additives.length > 0
                    ? Container(
                        padding: const EdgeInsets.only(top: 4),
                        height: 26,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: meal.additives.length,
                          itemBuilder: (_, index) {
                            if (meal.additives[index].isNumeric) {
                              return Text(meal.additives[index],
                                  style: const TextStyle(
                                      fontSize: 16, height: 1.4));
                            } else {
                              return Image.asset(
                                'assets/additives/${meal.additives[index]}.png',
                                height: 26,
                              );
                            }
                          },
                          separatorBuilder: (_, index) =>
                              Text(', ', style: const TextStyle(fontSize: 20)),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
