import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Modals/StockChart/StockpriceList_modal.dart';
import '../provider/timerCandle.dart';

class potrat extends StatefulWidget {
  const potrat({super.key});

  @override
  State<potrat> createState() => _potratState();
}

class _potratState extends State<potrat> {
  // late WebSocketChannel channel_m1;
  int num1 = 10;
  @override
  void initState() {
    // channel_m1 = IOWebSocketChannel.connect(
    //   Uri.parse(
    //     'ws://3.237.20.11:8080/livedata/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3MjczMjg0MX0.ojQ0lCT37M6f8ltpZxIJRHhQ2oFwsWpNvvVm-5dadGo/1m/eth-usd',
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 17, 19, 31),
          body: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assests/Arrow.svg"),
                    SizedBox(
                      width: 0.2 * w,
                    ),
                    Center(
                      child: Text(
                        "RelianceX Industries",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            color: Color.fromARGB(255, 220, 221, 223)),
                      ),
                    ),
                    Spacer(),
                    //  ProfilePic(context,)
                  ],
                ),
                SizedBox(
                  height: 0.05 * h,
                ),
                // Row(
                //   children: [
                //     StreamBuilder(
                //         stream: channel_m1.stream,
                //         builder: (context, snapshot) {
                //           if (snapshot.hasData) {
                //             var data = snapshot.data;

                //             List<dynamic> data1 = jsonDecode(data);
                //             // print(data1);
                //             print(DateTime.fromMillisecondsSinceEpoch(
                //                 (data1[0]["Datetime"])));
                //             print(data1[0]["Datetime"]);
                //             // List<dynamic> data1 = data;
                //             print("hello");
                //             var n = data1.length;
                //             // for (int i = 0; i < 9; i++) {
                //             //   List <dynamic>data2 = data1[]
                //             // }
                //             List<ChartSampleData> _getChart = data1
                //                 .map(
                //                   (e) => ChartSampleData.fromjson(e),
                //                 )
                //                 .toList();
                //             // print(_getChart);

                //             return chart111P(_getChart, context);
                //           } else {
                //             return Center(child: CircularProgressIndicator());
                //           }
                //         }),
                //   ],
                // ),

                SizedBox(height: 0.03 * h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 0.15 * w,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 0.05 * h, width: 0.3 * w),
                      child: ElevatedButton(
                        child: Center(
                          child: Text(
                            '1m',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 220, 221, 223)),
                          ),
                        ),
                        onPressed: () {
                          // setState(() {
                          //   // is_1min = true;
                          //   // channel_m2.sink.close();
                          //   // channel_m1;
                          // });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              // is_1min
                              //     ? Color.fromARGB(255, 31, 71, 211)
                              //     :
                              Color.fromARGB(255, 31, 32, 51),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.023 * w,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          height: 0.05 * h, width: 0.3 * w),
                      child: ElevatedButton(
                        child: Center(
                          child: Text(
                            '2m',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 220, 221, 223)),
                          ),
                        ),
                        onPressed: () {
                          // if (is_1min == true) {
                          //   setState(() {
                          //     is_1min = false;
                          //     channel_m1.sink.close();
                          //   });
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              // is_1min
                              //     ? Color.fromARGB(255, 31, 32, 51)
                              //     :
                              Color.fromARGB(255, 31, 71, 211),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 0.03 * h),
                Text(
                  "Number of Coins",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 220, 221, 223)),
                ),
                SizedBox(height: 0.03 * h),
                Row(
                  children: [
                    SizedBox(
                      width: 0.06 * w,
                    ),
                    GestureDetector(
                        onTap: () {
                          // if (num != 0) {
                          //   setState(() {
                          //     num1 = num1 - 10;
                          //   });
                          // }
                        },
                        child: SvgPicture.asset('assests/game/minus.svg')),
                    SizedBox(
                      width: 0.05 * w,
                    ),
                    Container(
                      height: 0.07 * h,
                      child: Center(
                          child: Text(
                        '$num1',
                        style: const TextStyle(color: Colors.white),
                      )),
                      width: 0.55 * w,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 30, 32, 51),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    SizedBox(
                      width: 0.05 * w,
                    ),
                    GestureDetector(
                        onTap: () {
                          // setState(() {
                          //   num1 = num1 + 10;
                          // });
                        },
                        child: SvgPicture.asset('assests/game/plus.svg')),
                  ],
                ),
                SizedBox(height: 0.025 * h),
                Row(
                  children: [
                    // SizedBox(
                    //   width: 0.07 * w,
                    // ),
                    GestureDetector(
                      onTap: () {
                        // PopUp(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(255, 36, 201, 171),
                        ),
                        height: 0.05 * h,
                        width: 0.44 * w,
                        child: Center(
                          child: Text(
                            'Green',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 0.03 * w,
                    ),
                    GestureDetector(
                      onTap: () {
                        // PopUp(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.red,
                        ),
                        height: 0.05 * h,
                        width: 0.44 * w,
                        child: Center(
                          child: Text(
                            'Red',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //line
              ],
            ),
          )),
    );
  }
}

// Widget chart111P(
//     List<ChartData> getChart, context, minX, maxX, lastCandle) {
//   double h = MediaQuery.of(context).size.height;
//   double w = MediaQuery.of(context).size.width;
//   String dn = " ";
//   String token = "";
//   return Row(children: [
//     Container(
//       // color: Colors.amber,
//       height: 0.8 * h,
//       width: 0.8 * w,
//       child: SfCartesianChart(
//         // trackballBehavior: _trackballBehavior,
//         plotAreaBorderColor: Color.fromARGB(255, 17, 19, 31),
//         series: <ChartSeries>[
//           CandleSeries<ChartData, DateTime>(
//               enableSolidCandles: true,
//               dataSource: getChart,
//               xValueMapper: (sal, _) => sal.dateTime,
//               lowValueMapper: (ChartData sale, _) => sale.Low,
//               highValueMapper: (ChartData sale, _) => sale.High,
//               openValueMapper: (ChartData sale, _) => sale.Open,
//               closeValueMapper: (ChartData sale, _) => sale.Close,
//               bearColor: Color.fromARGB(255, 255, 0, 0),
//               bullColor: Color.fromARGB(255, 0, 255, 102)),
//         ],
//         primaryXAxis: DateTimeAxis(
//           // axisLabelFormatter: (axisLabelRenderArgs) => ,
//           minimum: DateTime.fromMillisecondsSinceEpoch(minX),
//           maximum: DateTime.fromMillisecondsSinceEpoch(maxX),
//           edgeLabelPlacement: EdgeLabelPlacement.shift,
//           borderColor: Color.fromARGB(255, 255, 255, 255),
//           axisLine: AxisLine(width: 1),
//           majorGridLines: MajorGridLines(width: 0),
//         ),
//         primaryYAxis: NumericAxis(
//           majorGridLines: MajorGridLines(width: 0),
//         ),
//         backgroundColor: Color.fromARGB(255, 17, 19, 31),
//       ),
//     ),
//     Container(
//       margin: EdgeInsets.fromLTRB(0, 0.013 * h, 0, 0.042 * h),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           boxRed(LastCandle: lastCandle),
//         ],
//       ),
//     )
//   ]);
// }

class boxRed extends StatefulWidget {
  boxRed({super.key, required this.LastCandle});
  var LastCandle;
  @override
  State<boxRed> createState() => _boxRedState();
}

class _boxRedState extends State<boxRed> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  late Timer? _timer;
  bool _timerDisposed = false;

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

  void dispose() {
    _controller.dispose();
    print("_timer cancel");
    // _timer.cancel();
    _timerDisposed = true;

    // print(_timerDisposed);

    widget.LastCandle = 0;
    // Provider.of<timerCandle>(context, listen: false).dispose();
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
                      height: 0.23 * h,
                      width: 0.052 * w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        // border: Border.all(color: Colors.red, width: 1.5),
                      ),
                      child: Consumer<timerCandle>(
                          builder: (context, value, child) {
                        if (!_timerDisposed) {
                          _timer =
                              Timer.periodic(Duration(seconds: 1), (timer) {
                            // print(widget.state.isFlash);
                            if (!_timerDisposed) {
                              value.LeftTime(widget.LastCandle, _timerDisposed);
                              _timer!.cancel();
                            }
                            // print("call after ten s");
                          });
                        }
                        return RotatedBox(
                          quarterTurns: 45,
                          child: Center(
                            child: Text(
                              "${value.seconds}  Sec",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }))));
        }));
  }
}
