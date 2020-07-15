part of 'timetable_bloc.dart';

abstract class TimetableEvent extends Equatable {
  const TimetableEvent();
}

class LoadTimetableWeek extends TimetableEvent {
  final Settings settings;
  final DateTime weekStart;

  LoadTimetableWeek({
    @required this.settings,
    @required this.weekStart,
  });

  @override
  List<Object> get props => [weekStart];

  @override
  String toString() =>
      'LoadTimetableWeek { settings: $settings, weekStart: $weekStart }';
}
