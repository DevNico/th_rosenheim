import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/date_utils.dart';
import 'date_selector.dart';

class DateButton extends StatelessWidget {
  final DateTime today;
  final DateTime date;
  final DateTime selectedDate;
  final DateCallback onDaySelected;

  DateButton({
    @required this.today,
    @required this.date,
    @required this.selectedDate,
    @required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget child = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          DateFormat('E', 'de_DE')
              .format(date)
              .replaceAll('.', '')
              .replaceAll(r'(\d+)', r'$1\.'),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: theme.primaryTextTheme.subtitle1.color,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
        Text(
          DateFormat('dd', 'de_DE').format(date),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: date.isOnSameDayWith(selectedDate)
                ? Colors.orange[400]
                : date.weekday < DateTime.saturday
                    ? theme.primaryTextTheme.subtitle1.color
                    : Colors.red[700],
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ],
    );

    if (date.weekday < DateTime.saturday) {
      child = Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.transparent,
          shape: date.isOnSameDayWith(today)
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  side: BorderSide(
                    color: Colors.orange[400],
                    width: 1.5,
                  ),
                )
              : null,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            onTap: () => onDaySelected(date),
            child: child,
          ),
        ),
      );
    }

    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: child,
      ),
    );
  }
}
