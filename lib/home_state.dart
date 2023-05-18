import 'package:equatable/equatable.dart';

class HomeState {
  final int counter;
  final List<FoodItem> foodItems;

  HomeState({this.counter = 0, required this.foodItems});

  HomeState copyWith({
    int? counter,
    List<FoodItem>? foodItems,
  }) {
    return HomeState(
      counter: counter ?? this.counter,
      foodItems: foodItems ?? this.foodItems,
    );
  }
}

class FoodItem extends Equatable {
  final int id;
  final String name;
  final String imageUrl;
  final int qty;

  const FoodItem(
      {required this.id,
      required this.name,
      required this.imageUrl,
      this.qty = 0});

  FoodItem copyWith({
    String? name,
    String? imageUrl,
    int? qty,
  }) {
    return FoodItem(
      id: id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      qty: qty ?? this.qty,
    );
  }

  @override
  List<Object?> get props => [id];
}
