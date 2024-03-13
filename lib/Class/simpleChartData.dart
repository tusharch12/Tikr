import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../provider/pool_provider.dart';
import '../provider/timerCandle.dart';
import '../widget/CustomNotification.dart';

class ChartSampleData {
  DateTime dateTime;
  final num Open;
  final num High;
  final num Low;
  final num Close;

  ChartSampleData({
    required this.dateTime,
    required this.Open,
    required this.High,
    required this.Low,
    required this.Close,
  });

  factory ChartSampleData.fromjson(Map<String, dynamic> json) {
    return ChartSampleData(
        Open: json["Open"],
        High: json["High"],
        Low: json["Low"],
        Close: json["Close"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["Datetime"],
            isUtc: false));
  }
}

class chartFalRes {
  bool auth;
  DateTime dateTime;
  final num Open;
  final num High;
  final num Low;
  final num Close;

  chartFalRes({
    required this.auth,
    required this.dateTime,
    required this.Open,
    required this.High,
    required this.Low,
    required this.Close,
  });

  factory chartFalRes.fromjson(Map<String, dynamic> json) {
    return chartFalRes(
        auth: json["auth"],
        Open: json["Open"],
        High: json["High"],
        Low: json["Low"],
        Close: json["Close"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["Datetime"],
            isUtc: false));
  }
}

class MyWidget extends StatefulWidget {
  MyWidget({
    required this.dn,
    required this.token,
    required this.time_int,
    required this.lastCandle,
    super.key,
  });
  String dn;
  String token;
  int time_int;
  var lastCandle;
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  int num1 = 1;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => poolProvider(),
      child: Consumer<poolProvider>(
        builder: (context, value, child) {
          return PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),

            padding: const EdgeInsets.all(0),
            color: const Color.fromARGB(255, 78, 79, 87),
            constraints: const BoxConstraints(maxWidth: 154),
            // splashRadius: 120,
            child: box(
                time_interval: widget.time_int, lastcandle: widget.lastCandle),
            position: PopupMenuPosition.under,
            itemBuilder: (
              context,
            ) {
              return [
                PopupMenuItem(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 0,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: 30,
                        child: Row(
                          children: [
                            ZoomTapAnimation(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    num1 = num1 > 1 ? num1 - 1 : 1;
                                  });
                                },
                                child:
                                    SvgPicture.asset('assests/game/minus.svg')),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 25,
                              child: Center(
                                  child: Text(
                                '$num1',
                                style: TextStyle(
                                    fontSize: 0.04 * h,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                              width: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 30, 32, 51),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            ZoomTapAnimation(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    num1 = num1 + 1;
                                  });
                                },
                                child:
                                    SvgPicture.asset('assests/game/plus.svg')),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                    height: 0,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Container(
                      child: Row(
                        children: [
                          ZoomTapAnimation(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                var res = await ticket_purchaseL(
                                    "green",
                                    widget.dn,
                                    num1,
                                    widget.token,
                                    widget.time_int,
                                    value);
                                Future.delayed(Duration(milliseconds: 700), () {
                                  Navigator.pop(context);
                                  CustomMessageDisplay1 customMessageDisplay =
                                      CustomMessageDisplay1(context);
                                  customMessageDisplay.showMessage1(res["msg"]);
                                });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text(res["msg"])));
                              },
                              child: Container(
                                child: Center(
                                  child: Text("Green",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 0.04 * h,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600)),
                                ),
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color.fromARGB(
                                        255, 36, 201, 171)),
                              )),
                          const SizedBox(
                            width: 13,
                          ),
                          ZoomTapAnimation(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                var res = await ticket_purchaseL(
                                    "red",
                                    widget.dn,
                                    num1,
                                    widget.token,
                                    widget.time_int,
                                    value);
                                Future.delayed(Duration(milliseconds: 700), () {
                                  Navigator.pop(context);
                                  CustomMessageDisplay1 customMessageDisplay =
                                      CustomMessageDisplay1(context);
                                  customMessageDisplay.showMessage1(res["msg"]);
                                });
                              },
                              child: Container(
                                child: Center(
                                  child: Text("Red",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 0.04 * h,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600)),
                                ),
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 227, 51, 66)),
                              )),
                        ],
                      ),
                    ))
              ];
            },
          );
        },
      ),
    );
  }
}

ticket_purchaseL(String playdir, String instrument_name, int num, String token,
    int time_int, value) async {
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3MjgxNzA3NX0.A-RtQifbV5eNv54h1yWuM_MLy0dn9bULwh5KScIjn0o";
  // // int no_tic = int.parse(no_ticket);
  final String tpUrl = "http://34.204.28.184:8000/purchase_cc_ticket";
  var data = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  var data3 = data % 60;
  var data1 = (data - data3);
  var data2 = data1 + time_int;
  String interval = "";
  print(interval);
  print(instrument_name);
  var map = Map<String, dynamic>();
  map["play_time"] = data2.toString();
  map["no_tickets"] = num.toString();
  map["game_category"] = "in_stocks";
  map["instrument_name"] = instrument_name;
  map["interval"] = "1 min";
  map["player_type"] = await value.getplayer_type("player_type");
  map["pool_type"] = await value.getPool_type("pool_type");
  map["pool_code"] = await value.getPool_code("pool_code");
  map["play_direction"] = playdir;

  var response = await http.post(Uri.parse(tpUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  print(response.statusCode);
  var map1 = Map<String, dynamic>();
  var body = jsonDecode(response.body);
  var stat_code = response.statusCode;
  map1["msg"] = body["msg"];
  map1["scode"] = response.statusCode;
  print(response.body.runtimeType);
  return map1;
}

class box extends StatefulWidget {
  box({required this.time_interval, required this.lastcandle});
  var time_interval;
  var lastcandle;
  @override
  State<box> createState() => _boxState();
}

class _boxState extends State<box> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  Timer? _timer;
  bool _timerDisposed = false;

  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..forward()
          ..reverse()
          ..repeat();
    _animation = bgColor.animate(_controller);
  }

  Animatable<Color> bgColor = RainbowColorTween(
      [Colors.red, Color.fromARGB(255, 0, 255, 102), Colors.red]);

  void dispose() {
    _controller.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    print("_timer cancel");
    _timerDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animation,
        builder: ((context, child) {
          return DottedBorder(
              color: _animation.value,
              strokeWidth: 1.5,
              borderType: BorderType.RRect,
              radius: const Radius.circular(01),
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  child: Container(
                    // padding: EdgeInsets.all(12),
                    height: 0.32 * h,
                    width: 0.028 * w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      // border: Border.all(color: Colors.red, width: 1.5),
                    ),
                    child: Consumer<timerCandleL>(builder: (
                      context,
                      value,
                      child,
                    ) {
                      if (!_timerDisposed) {
                        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                          // print(widget.state.isFlash);

                          if (!_timerDisposed) {
                            widget.time_interval == 60
                                ? value.LeftTime1(
                                    widget.lastcandle, _timerDisposed)
                                : value.LeftTime3(
                                    widget.lastcandle, _timerDisposed);
                            _timer!.cancel();
                          }
                          // print("call after ten s");
                        });
                      }
                      return RotatedBox(
                        quarterTurns: 45,
                        child: Center(
                          child: Text(
                            widget.time_interval == 60
                                ? "${value.seconds1}"
                                : "${value.seconds3}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  )));
        }));
  }
}

class boxRed extends StatefulWidget {
  boxRed({super.key, required this.lastCandle});
  var lastCandle;
  @override
  State<boxRed> createState() => _boxRedState();
}

class _boxRedState extends State<boxRed> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  Timer? _timer;

  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..forward()
          ..reverse()
          ..repeat();
    _animation = bgColor.animate(_controller);
  }

  Animatable<Color> bgColor = RainbowColorTween([
    Color.fromARGB(255, 0, 255, 102),
    Colors.red,
    Color.fromARGB(255, 0, 255, 102),
  ]);

  bool _timerDisposed = false;
  void dispose() {
    _controller.dispose();
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
    print("_timer cancel");
    _timerDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
        animation: _animation,
        builder: ((context, child) {
          return DottedBorder(
              color: _animation.value,
              strokeWidth: 1.5,
              borderType: BorderType.RRect,
              radius: const Radius.circular(01),
              padding: const EdgeInsets.all(0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(0)),
                  child: Container(
                    height: 0.32 * h,
                    width: 0.028 * w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      // border: Border.all(color: Colors.red, width: 1.5),
                    ),
                    child: Consumer<timerCandleL>(builder: (
                      context,
                      value,
                      child,
                    ) {
                      if (!_timerDisposed) {
                        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                          if (!_timerDisposed) {
                            value.LeftTime2(widget.lastCandle, _timerDisposed);
                            _timer!.cancel();
                          }
                        });
                      }
                      return RotatedBox(
                        quarterTurns: 45,
                        child: Center(
                          child: Text(
                            "${value.seconds2}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
                  )));
        }));
  }
}

class MyCandle extends StatefulWidget {
  MyCandle({
    required this.dn,
    required this.token,
    required this.time_int,
    required this.lastCandle,
    super.key,
  });
  String dn;
  String token;
  int time_int;
  var lastCandle;

  @override
  State<MyCandle> createState() => _MyCandleState();
}

class _MyCandleState extends State<MyCandle> {
  int num1 = 1;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider(
      create: (context) => poolProvider(),
      child: Consumer<poolProvider>(
        builder: (context, value, child) {
          return PopupMenuButton(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),

            padding: const EdgeInsets.all(0),
            color: const Color.fromARGB(255, 78, 79, 87),
            constraints: const BoxConstraints(maxWidth: 154),
            // splashRadius: 120,
            child: boxRed(
              lastCandle: widget.lastCandle,
            ),
            position: PopupMenuPosition.under,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 0,
                  child: StatefulBuilder(
                    builder: (context, setState) {
                      return Container(
                        height: 30,
                        child: Row(
                          children: [
                            ZoomTapAnimation(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    num1 = num1 > 1 ? num1 - 1 : 1;
                                  });
                                },
                                child:
                                    SvgPicture.asset('assests/game/minus.svg')),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 25,
                              child: Center(
                                  child: Text(
                                '$num1',
                                style: TextStyle(
                                    fontSize: 0.04 * h,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              )),
                              width: 60,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 30, 32, 51),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ZoomTapAnimation(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    num1 = num1 + 1;
                                  });
                                },
                                child:
                                    SvgPicture.asset('assests/game/plus.svg')),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                    height: 0,
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: Container(
                      child: Row(
                        children: [
                          ZoomTapAnimation(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                var res = await ticket_purchase2(
                                    "green",
                                    widget.dn,
                                    num1,
                                    widget.token,
                                    widget.time_int,
                                    value);
                                Future.delayed(Duration(milliseconds: 700), () {
                                  Navigator.pop(context);
                                  CustomMessageDisplay1 customMessageDisplay =
                                      CustomMessageDisplay1(context);
                                  customMessageDisplay.showMessage1(res["msg"]);
                                });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text(res["msg"])));
                              },
                              child: Container(
                                child: Center(
                                  child: Text("Green",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 0.04 * h,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600)),
                                ),
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromARGB(255, 36, 201, 171)),
                              )),
                          const SizedBox(
                            width: 13,
                          ),
                          ZoomTapAnimation(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                var res = await ticket_purchase2(
                                    "red",
                                    widget.dn,
                                    num1,
                                    widget.token,
                                    widget.time_int,
                                    value);
                                Future.delayed(Duration(milliseconds: 700), () {
                                  Navigator.pop(context);
                                  CustomMessageDisplay1 customMessageDisplay =
                                      CustomMessageDisplay1(context);
                                  customMessageDisplay.showMessage1(res["msg"]);
                                });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text(res["msg"])));
                              },
                              child: Container(
                                child: Center(
                                  child: Text(
                                    "Red",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 0.04 * h,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                height: 25,
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 227, 51, 66)),
                              )),
                        ],
                      ),
                    ))
              ];
            },
          );
        },
      ),
    );
  }
}

ticket_purchase2(String playdir, String instrument_name, int num, String token,
    int time_int, value) async {
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3MjgxNzA3NX0.A-RtQifbV5eNv54h1yWuM_MLy0dn9bULwh5KScIjn0o";
  // // int no_tic = int.parse(no_ticket);
  final String tpUrl = "http://34.204.28.184:8000/purchase_cc_ticket";
  var data = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  var data3 = data % 60;
  var data1 = (data - data3);
  var data2 = data1 + time_int;
  String interval = "";
  // if (time_interval == true) {
  //   interval = "1 min";
  // } else if (time_interval == false) {
  //   interval = "2 min";
  // }
  print(interval);
  print(instrument_name);
  var map = Map<String, dynamic>();
  map["play_time"] = data2.toString();
  map["no_tickets"] = num.toString();
  map["game_category"] = "in_stocks";
  map["instrument_name"] = instrument_name;
  map["interval"] = "1 min";
  map["player_type"] = await value.getplayer_type("player_type");
  map["pool_type"] = await value.getPool_type("pool_type");
  map["pool_code"] = await value.getPool_code("pool_code");
  map["play_direction"] = playdir;

  var response = await http.post(Uri.parse(tpUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  // print(response.body);
  // print(response.body.runtimeType);
  print(response.statusCode);
  var map1 = Map<String, dynamic>();
  var body = jsonDecode(response.body);
  var stat_code = response.statusCode;
  map1["msg"] = body["msg"];
  map1["scode"] = response.statusCode;
  print(response.body.runtimeType);
  return map1;
}
