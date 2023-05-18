import 'package:equatable/equatable.dart';

abstract class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateError extends HomeState {
  final String errorMessage;

  HomeStateError(this.errorMessage);

}

class HomeStateLoaded extends HomeState {
  final int counter;
  final List<FoodItem> foodItems;

  HomeStateLoaded({this.counter = 0, required this.foodItems});

  HomeStateLoaded copyWith({
    int? counter,
    List<FoodItem>? foodItems,
  }) {
    return HomeStateLoaded(
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
