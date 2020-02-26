import 'dart:async';

import 'package:first_bloc_pro/counter_event.dart';

class CounterBolc {
  /// added the data ...
  int _counter = 0;

  /// create state controller ...
  /// which will be a steam controller ...
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;

  /// for state, exposing only a stream whick outputs data ...
  Stream<int> get counter => _counterStateController.stream;

  /// think about SteamController as a box which has two hols
  /// one for input and another one for output ...
  /// the input is called a Sink and the output is called a Stream
  /// whenever we add input throw Sink --> it is automatically go out throw Stream ...

  /// now we need a way to only receive the events from out side ...
  /// so we need to create another controller with only Sink because
  /// we will not stream event out [ we are not in need to stream event out]
  final _counterEventController = StreamController<CounterEvent>();
  Sink<CounterEvent> get counterEventSink => _counterEventController.sink;

  CounterBolc() {
    /// whenever there is a new event, we want to map it to a new state
    _counterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}


/// reference ...
/// https://www.youtube.com/watch?v=oxeYeMHVLII&list=PLB6lc7nQ1n4jCBkrirvVGr5b8rC95VAQ5&index=2&t=0s
