import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../data/splan_api.dart';
import '../../model/splan/model.dart';
import '../../model/splan/timetable_entry.dart';
import '../../utils/date_utils.dart';
import '../settings/settings_bloc.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<TimetableEvent, TimetableState> {
  @override
  TimetableState get initialState => TimetableInitial();

  @override
  Stream<TimetableState> mapEventToState(
    TimetableEvent event,
  ) async* {
    if (event is LoadTimetableWeek) {
      yield* _mapLoadTimetableWeekToState(event.settings, event.weekStart);
    }
  }

  Stream<TimetableState> _mapLoadTimetableWeekToState(Settings settings, DateTime weekStart) async* {
    if (settings.semester == null ||
        settings.course == null ||
        settings.lectures == null ||
        settings.lectures.length == 0) {
      yield TimetableEmpty();
    } else {
      final timetable = <int, List<TimetableEntry>>{};

      final newTimetable = await SplanApi().getTimetableWeek(
        // Hard coded due to disabled location selection.
        location: Location(id: 3),
        semester: settings.semester,
        lectures: settings.lectures,
        weekStart: weekStart,
      );

      if (state is TimetableLoaded) {
        final oldState = (state as TimetableLoaded);
        // Only add old data if the same settings were used to load it
        if (oldState.loadedWithSettings.semester == settings.semester &&
            oldState.loadedWithSettings.course == settings.course &&
            listEquals(oldState.loadedWithSettings.lectures, settings.lectures)) {
          timetable.addAll((state as TimetableLoaded).timetable);
        }
      }

      final baseInt = settings.semester.startDate.differenceInDaysWithoutWeekends(weekStart);

      if (newTimetable != null) {
        for (final entry in newTimetable.entries) {
          timetable[baseInt + entry.key] = entry.value;
        }
      }

      yield TimetableLoaded(
        loadedWithSettings: settings,
        timetable: timetable,
      );
    }
  }
}
