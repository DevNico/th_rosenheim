extension DurationExtension on Duration {
  String stringify() {
    final minute = (inMinutes % 60);
    final hour = inHours.floor();
    return '${hour < 10 ? '0$hour' : hour}'
        ':'
        '${minute < 10 ? '0$minute' : minute}';
  }
}

extension DateTimeExtension on DateTime {
  int get weekOfYear {
    final monday = weekStart();
    final first = _weekYearStartDate(monday.year);

    var week = 1 + (monday.difference(first).inDays / 7).floor();

    if (week == 53 && DateTime(monday.year, 12, 31).weekday < 4) week = 1;

    return week;
  }

  DateTime _weekYearStartDate(int year) {
    final firstDayOfYear = DateTime.utc(year, 1, 1);
    final dayOfWeek = firstDayOfYear.weekday;

    return firstDayOfYear.add(
        Duration(days: (dayOfWeek <= DateTime.thursday ? 1 : 8) - dayOfWeek));
  }

  int differenceInDaysWithoutWeekends(DateTime other) {
    var days = 0;
    var currentDate = this;

    while (currentDate.isBefore(other)) {
      currentDate = currentDate.add(Duration(days: 1));
      if (currentDate.weekday != DateTime.saturday &&
          currentDate.weekday != DateTime.sunday) {
        days += 1;
      }
    }

    return days;
  }

  DateTime weekStart() {
    // This is ugly, but to avoid problems with daylight saving
    var monday = DateTime.utc(year, month, day);
    if (monday.weekday != DateTime.monday) {
      monday = monday.subtract(Duration(days: monday.weekday - 1));
    }
    return monday;
  }

  DateTime weekEnd() {
    // This is ugly, but to avoid problems with daylight saving
    // Set the last microsecond to really be the end of the week
    var sunday = DateTime.utc(year, month, day, 23, 59, 59, 999, 999999);
    sunday = sunday.add(Duration(days: 7 - sunday.weekday));
    return sunday;
  }

  bool isOnSameDayWith(DateTime other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }

  DateTime withoutTime() => DateTime(year, month, day);

  bool isToday() => isOnSameDayWith(DateTime.now());
}
