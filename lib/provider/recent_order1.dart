import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../Modals/SettingPage_modal.dart';
import '../Modals/orders/orders_modal.dart';
import '../Page/Order page/order_Page.dart';
import '../Page/Setting Page/Setting_page.dart';

class recentOrderPro1 extends ChangeNotifier {
  bool loader1 = false;
  bool auth1 = false;
  bool isdeletePool = false;
  var response;
  List<order> RO = [];
  List<order> mainList = [];

  call(token) async {
    Future.delayed(Duration(seconds: 2)).then((_) {
      loader1 = true;
      notifyListeners();
    });

    response = await orderApiCall(token);
    print(response.runtimeType);
    auth1 = response["auth"];
    if (auth1 == true) {
      if (response["data"] != null &&
          response['data'].isNotEmpty &&
          response["data"][0].isNotEmpty) {
        List<dynamic> data = response["data"];
        mainList = data.map((e) => order.fromjson(e)).toList();
        // RO = data.map((e) => orderResposne.fromjson(e)).toList();
        // mainList = List.from(RO);
      }
    }
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
