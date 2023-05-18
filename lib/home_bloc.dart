import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/food_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodRepository _foodRepository = FoodRepository();

  HomeBloc() : super(HomeStateLoading()) {
    on((event, emit) async {
      switch (event.runtimeType) {
        case InitEvent:
        case RefreshEvent:
          {
            emit(HomeStateLoading());
            await _foodRepository.getFoodList().then((list) {
              final newState = HomeStateLoaded(foodItems: list);
              emit(newState);
            }, onError: (error) {
              emit(HomeStateError((error as Exception).toString()));
            });
          }
        case AddEvent:
          {
            final addEvent = (event as AddEvent);
            final currState = (state as HomeStateLoaded);
            final foodItem = currState.foodItems[addEvent.index];
            int totalCounter =
                foodItem.qty == 0 ? (currState.counter + 1) : currState.counter;
            currState.foodItems[addEvent.index] =
                foodItem.copyWith(qty: foodItem.qty + 1);
            emit(currState.copyWith(
                foodItems: currState.foodItems, counter: totalCounter));
          }
      }
    });
  }
}
