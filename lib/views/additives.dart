import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../locale/translation.dart';
import '../model/canteen.dart';
import '../utils/string_utils.dart';

class Additives extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final additives = additiveList.where((key) => key.length < 3);

    return Scaffold(
      appBar: AppBar(
        title: Text(ThTranslations.of(context).canteenAllergenes),
        backgroundColor: theme.primaryColorLight,
      ),
      body: ListView.separated(
        itemCount: additives.length,
        itemBuilder: (_, index) {
          final key = additives.elementAt(index);
          final value = ThTranslations.of(context).additive(key);
          final subtitle = additiveList
              .where((_key) => _key.contains(key) && _key.length == 3)
              .map((_key) => ThTranslations.of(context).additive(_key))
              .join(', ');

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: <Widget>[
                key.isNumeric
                    ? Container(
                        width: 32,
                        height: 32,
                        margin: EdgeInsets.only(right: 16),
                        child: AutoSizeText(
                          key,
                          minFontSize: 24,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      )
                    : key.length < 3
                        ? Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Image.asset(
                              'assets/additives/$key.png',
                              height: 32,
                            ),
                          )
                        : SizedBox(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        value,
                        style: theme.primaryTextTheme.subtitle1.copyWith(fontSize: 16),
                      ),
                      if (subtitle != '')
                        Text(
                          subtitle,
                          style: theme.primaryTextTheme.subtitle1.copyWith(fontSize: 15, color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, index) => Divider(),
      ),
    );
  }
}
