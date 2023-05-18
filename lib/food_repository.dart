import 'dart:async';

import 'package:faker/faker.dart';

import 'home_state.dart';

class FoodRepository {
  Future<List<FoodItem>> getFoodList() async {
    await Future.delayed(const Duration(seconds: 2));
    final faker = Faker();
    if (faker.randomGenerator.boolean()) {
      throw TimeoutException("Request time out");
    }
    final list = List.generate(5, (index) {
      final name = faker.food.cuisine();
      final imageUrl = faker.image
          .image(width: 200, height: 200, keywords: ["dish"], random: true);
      return FoodItem(
          id: faker.randomGenerator.integer(100000),
          name: name,
          imageUrl: imageUrl);
    });
    return Future.value(list);
  }
}
