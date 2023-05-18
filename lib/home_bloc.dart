import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/food_repository.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FoodRepository _foodRepository = FoodRepository();

  HomeBloc() : super(HomeState(foodItems: [], counter: 0)) {
    on((event, emit) async {
      switch (event.runtimeType) {
        case InitEvent:
          {
            final list = await _foodRepository.getFoodList();
            final newState = state.copyWith(foodItems: list);
            emit(newState);
          }
        case AddEvent:
          {
            final addEvent = (event as AddEvent);
            final foodItem = state.foodItems[addEvent.index];
            int totalCounter =
                foodItem.qty == 0 ? (state.counter + 1) : state.counter;
            state.foodItems[addEvent.index] =
                foodItem.copyWith(qty: foodItem.qty + 1);
            emit(state.copyWith(
                foodItems: state.foodItems, counter: totalCounter));
          }
      }
    });
  }
}
