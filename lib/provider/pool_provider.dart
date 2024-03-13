import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tikr/Modals/homePage/homePageStockList_modal.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Page/HomePage/Home_Page.dart';

class poolProvider extends ChangeNotifier {
  final storage = FlutterSecureStorage();
  bool isFlash = false;

  flash_true(bool) {
    isFlash = true;
    notifyListeners();
  }

  flash_false(bool) {
    isFlash = false;
    notifyListeners();
  }

  getPool_name(_keyToken) async {
    var tk = await storage.read(key: _keyToken);
    print(tk);
    if (tk == null || tk == "BOT") {
      return "BOT";
    } else {
      return tk;
    }
  }

  getplayer_type(_keyToken) async {
    var tk = await storage.read(key: _keyToken);
    print(tk);
    if (tk == null || tk == "BOT") {
      return "BOT";
    } else {
      return tk;
    }
  }

  getPool_type(_keyToken) async {
    var tk = await storage.read(key: _keyToken);
    print(tk);
    if (tk == null || tk == "NA") {
      return "NA";
    } else {
      return tk;
    }
  }

  getPool_code(_keyToken) async {
    var tk = await storage.read(key: _keyToken);
    print(tk);
    if (tk == null || tk == "BOT") {
      return "NA";
    } else {
      return tk;
    }
  }

  int value = 1;
  String pool_name = "BOT";
  String player_type = "POOL";
  String pool_type = "NA";
  String pool_code = "NA";
  String get poolName => pool_name;
  // String get poolName => getToken("pool_name");
  String get playerType => player_type;
  String get poolType => pool_type;
  String get poolCode => pool_code;

  void playertype(String PT) async {
    await storage.write(key: 'player_type', value: PT);
    player_type = PT;
    notifyListeners();
  }

  void poolcode(String pc) async {
    await storage.write(key: 'pool_code', value: pc);
    pool_code = pc;
    notifyListeners();
  }

  void pooltype(String pt) async {
    await storage.write(key: 'pool_type', value: pt);
    pool_type = pt;
    notifyListeners();
  }

  void poolname(String pn) async {
    await storage.write(key: 'pool_name', value: pn);
    pool_name = pn;
    print("From the provider class");
    print(pool_name);
    notifyListeners();
  }

  bool loader = false;
  bool homeListAuth = false;
  bool isdeletePool = false;
  var response;
  var res;
  List<homePageStockList_modal> PP = [];
  List<homePageStockList_modal> mainList = [];

  call(token) async {
    res = await homeList().getListdata(token);
    if (res.statusCode.toString().isNotEmpty) loader = true;
    response = jsonDecode(res.body);
    homeListAuth = await response["auth"];

    if (homeListAuth == true) {
      List<dynamic> data1 = response["data"];
      PP = data1.map((e) => homePageStockList_modal.fromjson(e)).toList();

      mainList = List.from(PP);
      print("after calli");
      print(mainList);
    }
    notifyListeners();
  }
   updatelist(String value) {
    mainList = PP
        .where((element) =>
            element.display_name.toLowerCase().contains(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
