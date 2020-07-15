part of 'canteen_bloc.dart';

abstract class CanteenEvent extends Equatable {
  const CanteenEvent();
}

class LoadCanteenWeek extends CanteenEvent {
  final DateTime firstDay;
  final DateTime weekStart;

  LoadCanteenWeek({
    @required this.firstDay,
    @required this.weekStart,
  });

  @override
  List<Object> get props => [weekStart];

  @override
  String toString() =>
      'LoadCanteenWeek { firstDay: $firstDay, weekStart: $weekStart }';
}
