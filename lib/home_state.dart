class HomeState {
  final int counter;

  HomeState({this.counter = 0});

  HomeState copyWith({
    int? counter,
  }) {
    return HomeState(
      counter: counter ?? this.counter,
    );
  }
}