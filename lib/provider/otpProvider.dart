import 'dart:async';

import 'package:flutter/cupertino.dart';

class timer extends ChangeNotifier {
  bool isEnable = false;

  int timer1 = 0;
  StreamController<int> _timerController = StreamController<int>();

  Stream<int> get timerStream => _timerController.stream;

  void startTimer() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      timer1++;

      // _timerController.add(_timer);
      notifyListeners();
    });
  }

  time1() {
    isEnable = !isEnable;
    notifyListeners();
  }
}
