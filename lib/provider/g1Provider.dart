import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Services/secureData.dart';

class G1Provider extends ChangeNotifier {
  int? value;

  G1Provider() {
    initializeValue();
  }

  Future<void> initializeValue() async {
    // value = await saveData().getTickVal('tick_val');
    notifyListeners();
  }

  void increaseNum() {
    value = (value ?? 0) + 1;

    notifyListeners();
  }

  void decreaseNum() {
    if (value != null && value! > 0) {
      value = value! - 1;
      notifyListeners();
    }
  }
}

class g1Provider extends ChangeNotifier {
  // int value = 1;
  int ticket = 0;

  int? value;

  g1Provider() {
    initializeValue();
  }

  Future<void> initializeValue() async {
    String val = await saveData().getTickVal('tick_val');
    value = int.parse(val);
    notifyListeners();
  }

  void increase_num(int val) async {
    value = (value ?? 0) + 1;
    notifyListeners();
  }

  void des_num() {
    if (value != null && value! > 0) {
      value = value! - 1;
      notifyListeners();
    }
  }
}

class g1ProviderChartP extends ChangeNotifier {
  bool is_min1 = true;
  String formattedDate = "";
  currTime() {
    int interval;
    if (is_min1 == true) {
      interval = 60;
    } else {
      interval = 120;
    }
    // currentTime = DateTime.now();
    var data = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var data3 = data % 60;
    var data1 = (data - data3);
    var data2 = data1 + interval;

    // val = data2;
    double time = double.parse(data2.toString());
    // print(time);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch((data2 * 1000).toInt()).toLocal();
    notifyListeners();
    return formattedDate = DateFormat('HH:mm a').format(dateTime);
  }

  void Min1() {
    is_min1 = true;
    notifyListeners();
  }

  void min2() {
    is_min1 = false;
    notifyListeners();
  }
}

class g1ProviderChartL extends ChangeNotifier {
  bool is_min1 = true;

  void Min1() {
    is_min1 = true;
    notifyListeners();
  }

  void min2() {
    is_min1 = false;
    notifyListeners();
  }
}
