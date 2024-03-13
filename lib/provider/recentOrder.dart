import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Modals/orders/orders_modal.dart';
import '../Page/Order page/order_Page.dart';
import '../Page/Setting Page/Setting_page.dart';
import '../Modals/settingPage_modal.dart';

class recentOrderPro extends ChangeNotifier {
  bool loader = false;
  bool auth = false;
  bool isdeletePool = false;
  String msg = '';
  var res;
  var response;
  List<order> RO = [];
  List<order> mainList = [];

  call(token) async {
    try {
      print("2");
      res = await orderApiCall(token);

      print("gsajfgj");
      print(res.statusCode);
      if (res.statusCode.toString().isNotEmpty) loader = true;
      response = jsonDecode(res.body);
      print(response);
      auth = response["auth"];
      msg = response["msg"];
      if (auth == true) {
        if (response["data"] != null &&
            response['data'].isNotEmpty &&
            response["data"][0].isNotEmpty) {
          List<dynamic> data = response["data"];
          mainList = data.map((e) => order.fromjson(e)).toList();
          // RO = data.map((e) => orderResposne.fromjson(e)).toList();
          // mainList = List.from(RO);
        }
      }
    } catch (e) {
      print(e);
    }

    print("3");
    notifyListeners();
  }

  late userProfileRes profileResBody;
  bool profileAuth = false;
  bool Profileloader = false;
  var apiResponse;
  ProfileApiCall(token) async {
    Future.delayed(Duration(seconds: 2)).then((_) {
      Profileloader = true;
      notifyListeners();
    });
    apiResponse = await getUserIdApi(token);
    var data1 = jsonDecode(apiResponse["body"]);
    profileAuth = data1["auth"];
    print('object');
    print(profileAuth);

    profileResBody = userProfileRes.fromJson(data1);
    print("ProfileLoder");
    print(Profileloader);
    notifyListeners();
  }
}
