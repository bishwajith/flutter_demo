import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class CounterBloc extends Bloc<HomeEvent, HomeState> {
  CounterBloc() : super(HomeState()) {
    on((event, emit) {
      switch (event) {
        case HomeEvent.increment:
          {
            final newState = state.copyWith(counter: state.counter + 1);
            emit(newState);
          }
          break;
        case HomeEvent.decrement:
          {
            final newState = state.copyWith(counter: state.counter - 1);
            emit(newState);
          }
          break;
        case HomeEvent.reset:
          {
            final newState = state.copyWith(counter: 0);
            emit(newState);
          }
      }
    });
  }
}
