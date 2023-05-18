import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo/home_bloc.dart';
import 'package:flutter_demo/home_event.dart';
import 'package:flutter_demo/home_state.dart';

class MyListWidget extends StatelessWidget {
  const MyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: context.read<HomeBloc>(),
        builder: (context, state) {
          if (state is HomeStateLoading) {
            return const CircularProgressIndicator();
          } else if (state is HomeStateError) {
            return ListView(
              children: [
                Center(
                  child: Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          } else if (state is HomeStateLoaded) {
            final foodItems = state.foodItems;
            return ListView.builder(
                itemBuilder: (context, index) {
                  return MyItemWidget(
                    foodItem: foodItems[index],
                    index: index,
                  );
                },
                itemCount: state.foodItems.length);
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}

class MyItemWidget extends StatefulWidget {
  final FoodItem foodItem;
  final int index;

  const MyItemWidget({super.key, required this.foodItem, required this.index});

  @override
  State<MyItemWidget> createState() => _MyItemWidgetState();
}

class _MyItemWidgetState extends State<MyItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Image.network(
                widget.foodItem.imageUrl,
                width: 120,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.foodItem.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      "Qty: ${widget.foodItem.qty}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ))),
                  onPressed: () {
                    context.read<HomeBloc>().add(AddEvent(widget.index));
                  },
                  child: const Text("Add")),
            )
          ],
        ),
      ),
    );
  }
}
