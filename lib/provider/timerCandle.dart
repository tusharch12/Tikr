import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class timerCandle extends ChangeNotifier {
  int seconds = 0;
  bool isMin1 = true;
  LeftTime(lastCandle, _timerDispose) {
    // print(_timerDispose);
    if (!_timerDispose) {
      if (isMin1 == true) {
        lastCandle = lastCandle + 60000;
        DateTime now = DateTime.now();
        int timestampInSeconds = (now.millisecondsSinceEpoch).round();
        seconds = lastCandle - timestampInSeconds;
        seconds = (seconds / 1000).toInt();
        // print(seconds);
        if (seconds < 0) {
          seconds = 0;
        }
        // print("function will be called");
      } else {
        lastCandle = lastCandle + 120000;
        DateTime now = DateTime.now();
        int timestampInSeconds = (now.millisecondsSinceEpoch).round();

        seconds = lastCandle - timestampInSeconds;
        seconds = (seconds / 1000).toInt();
        if (seconds <= 0) {
          seconds = 0;
        }
      }
      notifyListeners();
    }
  }

  void Min1() {
    isMin1 = true;
    notifyListeners();
  }

  void min2() {
    isMin1 = false;
    print("helo gfhddhjk");
    notifyListeners();
  }
}

class timerCandleL extends ChangeNotifier {
  String seconds1 = "";
  String seconds2 = "";
  String seconds3 = '';
  bool isMin1 = true;

  LeftTime1(lastCandle, _timerDisposed) {
    if (!_timerDisposed) {
      if (isMin1 == true) {
        lastCandle = lastCandle + 60000;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((lastCandle).toInt());
        // print(dateTime);
        seconds1 = DateFormat('HH:mm a').format(dateTime);
        notifyListeners();
      } else {
        lastCandle = lastCandle + 120000;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((lastCandle).toInt());
        // print(dateTime);
        seconds1 = DateFormat('HH:mm a').format(dateTime);
        // print(seconds1);
        notifyListeners();
      }
    }
  }

  LeftTime2(lastCandle, _timerDisposed) {
    if (!_timerDisposed) {
      if (isMin1 == true) {
        lastCandle = lastCandle + 120000;
        // print(lastCandle);
        // seconds2 = lastCandle;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((lastCandle).toInt()).toLocal();

        seconds2 = DateFormat('HH:mm a').format(dateTime);
        //  print(seconds2);
        // print(seconds2);
        notifyListeners();
      } else {
        lastCandle = lastCandle + 240000;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((lastCandle).toInt()).toLocal();

        seconds2 = DateFormat('HH:mm a').format(dateTime);
        notifyListeners();
      }
    }
  }

  LeftTime3(lastCandle, _timerDisposed) {
    if (!_timerDisposed) {
      if (isMin1 == true) {
        // print(lastCandle);
        lastCandle = lastCandle + 180000;
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((lastCandle).toInt()).toLocal();
        seconds3 = DateFormat('HH:mm a').format(dateTime);
        notifyListeners();
      } else {
        lastCandle = lastCandle + 360000;
        // print(lastCandle);
        // seconds3 = lastCandle.toInt();

        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch((lastCandle).toInt()).toLocal();
        seconds3 = DateFormat('HH:mm a').format(dateTime);
        notifyListeners();
      }
    }
  }

  void Min1() {
    isMin1 = true;
    notifyListeners();
  }

  void min2() {
    isMin1 = false;
    notifyListeners();
  }
}
