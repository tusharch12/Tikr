import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tikr/widget/ProfilePicWidget.dart';
import '../Modals/Pools/JoinPool_modal.dart';
import '../Modals/Pools/PublicPool_modal.dart';
import '../Page/Search page/searchPage.dart';

class searchPool extends ChangeNotifier {
  bool loader = true;
  bool auth = false;
  String error = '';
  String msg = '';
  bool isError = false;
  bool isdeletePool = false;
  var response;
  var res;
  List<publicPool> PP = [];
  List<publicPool> mainList = [];

  call(token) async {
    try {
      res = await pub_pool(token);
      if (res.statusCode == 201) loader = false;
      response = jsonDecode(res.body);
      auth = response["auth"];
      msg = response["msg"];
      if (auth == true) {
        List<dynamic> data1 = response["data"];
        PP = data1.map((e) => publicPool.fromjson(e)).toList();
        mainList = List.from(PP);
      }
    } catch (err) {
      loader = false;
      isError = true;

      // error = err.toString();
      print(err);
    }

    notifyListeners();
  }

  updatelist(String value) {
    mainList = PP
        .where((element) =>
            element.pool_name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }

  deletePool() {
    print(" callDelte");
    isdeletePool != isdeletePool;
    notifyListeners();
  }

  var myPoolListRes;
  List<JoinPools> PI = [];

  getMyPoolList(String token) async {
    myPoolListRes = await getPool(token);
    PI = myPoolListRes;
    notifyListeners();
  }
}
