import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Page/HomePage/Home_Page.dart';

class timer extends ChangeNotifier {
  bool is_min1 = true;
  String formattedDate = "";
  bool isMarketOpen = false;
  predictTimer(token) async {
    var res = await marketApi(token);
    isMarketOpen = res["status"];
    notifyListeners();
  }

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

    formattedDate = DateFormat('HH:mm a').format(dateTime);
    notifyListeners();
  }

  void Min1() {
    is_min1 = true;
    notifyListeners();
  }

  void min2() {
    is_min1 = false;
    notifyListeners();
  }

  setvalue(String value) {
    formattedDate = value;
  }
}
// class g1ProviderChartL extends ChangeNotifier {
//   bool is_min1 = true;

//   void Min1(bool is_min1) {
//     is_min1 = true;
//     notifyListeners();
//   }

//   void min2(bool is_min1) {
//     is_min1 = false;
//     notifyListeners();
//   }
// }
