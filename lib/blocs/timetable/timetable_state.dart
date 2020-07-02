part of 'timetable_bloc.dart';

abstract class TimetableState extends Equatable {
  const TimetableState();
}

class TimetableInitial extends TimetableState {
  @override
  List<Object> get props => [];
}

class TimetableLoaded extends TimetableState {
  final Settings loadedWithSettings;
  final Map<int, List<TimetableEntry>> timetable;

  TimetableLoaded({
    @required this.loadedWithSettings,
    @required this.timetable,
  });

  @override
  List<Object> get props => [loadedWithSettings, timetable.map((k, v) => MapEntry(k, v.length))];

  @override
  String toString() => 'TimetableLoaded { timetable: ${timetable.map((key, value) => MapEntry(key, value.length))} }';
}

class TimetableEmpty extends TimetableState {
  @override
  List<Object> get props => [];
}
