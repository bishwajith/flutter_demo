import 'dart:async';

class CounterBloc {
  final StreamController<int> _steamController = StreamController<int>();
  late StreamSink<int> sink;
  late Stream<int> stream;
  int counter = 0;

  CounterBloc() {
    sink = _steamController.sink;
    stream = _steamController.stream;
    sink.add(0);
  }

  increment() {
    counter += 1;
    sink.add(counter);
  }
}
