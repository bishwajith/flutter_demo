abstract class HomeEvent { }

class InitEvent extends HomeEvent {}

class RefreshEvent extends HomeEvent {}

class AddEvent extends HomeEvent {
  final int index;

  AddEvent(this.index);
}
