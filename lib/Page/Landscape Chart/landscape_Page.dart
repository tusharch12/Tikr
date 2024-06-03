import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:provider/provider.dart';
import 'package:tikr/Page/Landscape%20Chart/Chart.dart';
import 'package:tikr/Page/g1new.dart';
import 'package:tikr/Page/signIn.dart';
import 'package:tikr/provider/g1Provider.dart';
import 'package:tikr/provider/timerCandle.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../Modals/StockChart/StockpriceList_modal.dart';


class LandScapeChart extends StatefulWidget {
  LandScapeChart({
    super.key,
    required this.dn,
    required this.data,
    required this.token,
  });
  String dn;
  String data;
  String token;
  @override
  State<LandScapeChart> createState() => _LandScapeChartState();
}

class _LandScapeChartState extends State<LandScapeChart> {
  // late WebSocketChannel channel_m1;
  // late WebSocketChannel channel_m2;
  late WebSocketChannel channel;
  @override
  void initState() {
    super.initState();
    print("call initfunction L 2m");
    channel = IOWebSocketChannel.connect(
      Uri.parse(
        'ws://34.204.28.184:8080/livedata/' +
            widget.token +
            '/2m/' +
            widget.data,
      ),
    );
    channel.sink.close();
  }

  void dispose() {
    print("disConnect L");
    print(DateTime.now());
    channel.sink.close();
    // channel.sink.close();
    super.dispose();
  }

  sc1m() {
    channel.sink.close();
    channel = IOWebSocketChannel.connect(
      Uri.parse(
        'ws://34.204.28.184:8080/livedata/' +
            widget.token +
            '/1m/' +
            widget.data,
      ),
    );
    print("1m L");
    print(DateTime.now());
    return channel.stream;
  }

  sc2m() {
    channel.sink.close();
    channel = IOWebSocketChannel.connect(
      Uri.parse(
        'ws://34.204.28.184:8080/livedata/' +
            widget.token +
            '/2m/' +
            widget.data,
      ),
    );
    print("2m L");
    print(DateTime.now());
    return channel.stream;
  }

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider<g1ProviderChartL>(
        create: (context) => g1ProviderChartL(),
        child: ChangeNotifierProvider(
            create: (context) => timerCandleL(),
            child:
                Consumer<g1ProviderChartL>(builder: (context, provide, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Color.fromARGB(255, 17, 19, 31),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          0.046 * w, 0.07 * w, 0.046 * w, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ZoomTapAnimation(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset(
                              Images.back,
                              height: 0.08 * h,
                              width: 0.06 * w,
                            ),
                          ),
                          SizedBox(
                            width: 0.030 * w,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                height: 0.04 * w, width: 0.1 * w),
                            child: ElevatedButton(
                              child: Center(
                                child: Text(
                                  '1m',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 0.035 * h,
                                      fontFamily: 'Poppins',
                                      color:
                                          Color.fromARGB(255, 220, 221, 223)),
                                ),
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Provider.of<timerCandleL>(context,
                                        listen: false)
                                    .Min1();
                                if (provide.is_min1 == false) {
                                  provide.Min1();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: provide.is_min1
                                    ? Color.fromARGB(255, 31, 71, 211)
                                    : Color.fromARGB(255, 31, 32, 51),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.02 * w,
                          ),
                          ConstrainedBox(
                            constraints: BoxConstraints.tightFor(
                                height: 0.04 * w, width: 0.1 * w),
                            child: ElevatedButton(
                              child: Center(
                                child: Text(
                                  '2m',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 0.035 * h,
                                      fontFamily: 'Poppins',
                                      color:
                                          Color.fromARGB(255, 220, 221, 223)),
                                ),
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();

                                if (provide.is_min1 == true) {
                                  provide.min2();
                                  Provider.of<timerCandleL>(context,
                                          listen: false)
                                      .min2();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: provide.is_min1
                                    ? Color.fromARGB(255, 31, 32, 51)
                                    : Color.fromARGB(255, 31, 71, 211),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Center(
                            child: Text(
                              widget.dn,
                              style: TextStyle(
                                color: Color.fromARGB(255, 220, 221, 233),
                                fontSize: 0.043 * h,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Spacer(),
                          ZoomTapAnimation(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              final isP = MediaQuery.of(context).orientation ==
                                  Orientation.portrait;

                              if (isP) {
                                setL();
                              } else {
                                setP();
                              }
                            },
                            child: SvgPicture.asset(
                              'assests/rotate2.svg',
                             height: 0.08 * h,
                              width: 0.06 * w,
                              // width: 0.041 * w,
                            ),
                          )
                          //ProfilePic(context)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.01 * h,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                      child: Row(
                        children: [
                          Container(
                            // color: Colors.amber,
                            // padding:
                            // EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                            height: 0.7 * h,
                            width: 0.9 * w,
                            child: StreamBuilder(
                                stream: provide.is_min1 ? sc1m() : sc2m(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    var data = snapshot.data;
                                    // print(data);
                                    var response_b = jsonDecode(data as String);
                                    // print(response_b["auth"]);
                                    if (response_b is Map &&
                                        response_b.containsKey("auth")) {
                                      if (response_b["auth"] == "false") {
                                        return SignUpButton(w, h);
                                      } else {
                                        return Center(
                                          child: Text(
                                            "chart is not available",
                                            style: TextStyle(
                                                fontSize: 0.045 * w,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w200,
                                                color: Colors.white),
                                          ),
                                        );
                                      }
                                    } else {
                                      List<dynamic> data1 =
                                          jsonDecode(data.toString());

                                      var n = data1.length;
                                      var minX = data1[0]["Datetime"] - 60000;
                                      var maxX = data1[8]["Datetime"] + 60000;
                                      var lastCandle = data1[8]["Datetime"];
                                      print(lastCandle);
                                      List<ChartData> _getChart = data1
                                          .map(
                                            (e) => ChartData.fromjson(e),
                                          )
                                          .toList();
                                      return chartL(
                                          _getChart,
                                          context,
                                          widget.dn,
                                          widget.token,
                                          minX,
                                          maxX,
                                          lastCandle);
                                    }
                                  } else {
                                    return Center(
                                        child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0.03 * w, 0, 0.03 * w, 0),
                                            child: loader(context, w, h)));
                                  }
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            })));
  }
}
