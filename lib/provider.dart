import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int count = 0;

  void increment([int step = 1]) {
    count += step;
    notifyListeners();
  }

  void decrement([int step = 1]) {
    count -= step;
    notifyListeners();
  }

  void reset() {
    count = 0;
    notifyListeners();
  }
}
