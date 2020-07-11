import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/eat_api.dart';
import '../../model/canteen.dart';
import '../../utils/date_utils.dart';

part 'canteen_event.dart';
part 'canteen_state.dart';

class CanteenBloc extends Bloc<CanteenEvent, CanteenState> {
  CanteenBloc() : super(CanteenInitial());

  @override
  Stream<CanteenState> mapEventToState(
    CanteenEvent event,
  ) async* {
    if (event is LoadCanteenWeek) {
      yield* _mapLoadCanteenWeekToState(event.firstDay, event.weekStart);
    }
  }

  Stream<CanteenState> _mapLoadCanteenWeekToState(DateTime firstDay, DateTime weekStart) async* {
    final canteen = <int, List<CanteenMeal>>{};

    final newCanteen = await EatApi().getCanteenWeek(
      year: weekStart.year,
      week: weekStart.weekOfYear,
    );

    if (state is CanteenLoaded) {
      final oldState = (state as CanteenLoaded);
      canteen.addAll(oldState.canteen);
    }

    if (newCanteen != null) {
      for (final day in newCanteen.days) {
        canteen[firstDay.differenceInDaysWithoutWeekends(day.date)] = day.dishes;
      }
    }

    final diff = firstDay.differenceInDaysWithoutWeekends(weekStart);
    for (var i = diff; i < diff + 5; i++) {
      if (!canteen.containsKey(i)) canteen[i] = [];
    }

    // canteen.forEach((key, value) => logger.d('$key: ${value.length}'));

    yield CanteenLoaded(canteen);
  }
}
