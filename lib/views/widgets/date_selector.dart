import 'package:flutter/material.dart';

import '../../utils/date_utils.dart';
import 'date_button.dart';

typedef DateCallback = void Function(DateTime date);

class DateSelector extends StatefulWidget {
  final DateTime today;
  final DateTime selectedDate;
  final DateTime startDate;
  final DateTime endDate;
  final DateCallback onDaySelected;
  final DateCallback onSwipe;

  DateSelector({
    Key key,
    @required this.today,
    @required this.selectedDate,
    @required this.startDate,
    @required this.endDate,
    @required this.onDaySelected,
    @required this.onSwipe,
  }) : super(key: key);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: (widget.endDate.difference(widget.selectedDate).inDays / 7).ceil().abs(),
    );
    _pageController.addListener(() {
      widget.onSwipe(_currentWeekStart);
    });
  }

  DateTime get _currentWeekStart => widget.selectedDate
      .weekStart()
      .add(Duration(days: 7 * (_pageController.page.round() - _pageController.initialPage)));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: PageView.builder(
        itemCount: (widget.endDate.difference(widget.startDate).inDays / 7).ceil().abs(),
        physics: ClampingScrollPhysics(),
        controller: _pageController,
        itemBuilder: (_, i) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: List<int>.generate(7, (i) => i)
                .map((index) => widget.selectedDate
                    .weekStart()
                    .add(Duration(days: 7 * (i - _pageController.initialPage)))
                    .add(Duration(days: index)))
                .map((date) => DateButton(
                      today: widget.today,
                      date: date,
                      selectedDate: widget.selectedDate,
                      onDaySelected: (date) {
                        widget.onDaySelected(date);
                      },
                    ))
                .toList(),
          );
        },
      ),
    );
  }
}
