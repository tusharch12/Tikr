import 'dart:convert';
import 'package:http/http.dart' as http;

ticket_purchase(String playdir, String instrument_name, int num,
    bool time_interval, String token, state) async {
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3MjgxNzA3NX0.A-RtQifbV5eNv54h1yWuM_MLy0dn9bULwh5KScIjn0o";
  // // int no_tic = int.parse(no_ticket);
  final String tpUrl = "http://34.204.28.184:8000/purchase_cc_ticket";
  var data = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  var data3 = data % 60;
  var data1 = (data - data3);
  var data2 = data1 + 60;
  String interval = "";
  if (time_interval == true) {
    interval = "1 min";
  } else if (time_interval == false) {
    interval = "2 min";
  }
  print(interval);
  var map = Map<String, dynamic>();
  map["play_time"] = data2.toString();
  map["no_tickets"] = num.toString();
  map["game_category"] = "in_stocks";
  map["instrument_name"] = instrument_name;
  map["interval"] = interval;
  map["player_type"] = await state.getplayer_type("player_type");
  map["pool_type"] = await state.getPool_type("pool_type");
  map["pool_code"] = await state.getPool_code("pool_code");
  map["play_direction"] = playdir;

  print(map);
  var response = await http.post(Uri.parse(tpUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);

  var map1 = Map<String, dynamic>();
  var body = jsonDecode(response.body);
  // print(response.body);

  map1["body"] = body;
  map1["msg"] = body["msg"];

  map1["statusCode"] = response.statusCode;
  print(map1); // print(response.statusCode);
  return map1;
}
