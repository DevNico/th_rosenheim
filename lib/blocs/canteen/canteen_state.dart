part of 'canteen_bloc.dart';

abstract class CanteenState extends Equatable {
  const CanteenState();
}

class CanteenInitial extends CanteenState {
  @override
  List<Object> get props => [];
}

class CanteenLoaded extends CanteenState {
  final Map<int, List<CanteenMeal>> canteen;

  CanteenLoaded(this.canteen);

  @override
  List<Object> get props => canteen.values.toList();
}
