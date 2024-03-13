import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Modals/StockChart/StockpriceList_modal.dart';
import '../widget/ineternet_connection.dart';
import 'Potrait Chart/potraitCharPaget.dart';
import 'Landscape Chart/landscape_Page.dart';
import '../class/simpleChartData.dart';

class g11 extends StatefulWidget {
  g11({
    required this.dn,
    required this.data,
    required this.token,
    required this.state,
    super.key,
  });
  var state;
  String dn;
  String token; String data;
 

  @override
  State<g11> createState() => _g11State();
}

class _g11State extends State<g11> {
  late ValueNotifier<bool?> _isConnected;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    super.initState();
    _isConnected = ValueNotifier<bool?>(null);
    _initConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _isConnected.value = result != ConnectivityResult.none;
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _isConnected.dispose();
    super.dispose();
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      print(e);
    }
    _isConnected.value = result != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<bool?>(
      valueListenable: _isConnected,
      builder: (context, isConnected, child) {
        return isConnected == null
            ? buildLoading()
            : isConnected
                ? g1new(
                    dn: widget.dn,
                    data: widget.data,
                    token: widget.token,
                    state: widget.state,
                    )
                : buildNoInternet(context);
      },
    );
  }
}

class g1new extends StatefulWidget {
  g1new({
    required this.dn,
    required this.data,
    required this.token,
    required this.state,
  
    super.key,
  });
  var state;
  String dn;
  String token;
  String data;

  @override
  State<g1new> createState() => _g1newState();
}

class _g1newState extends State<g1new> {
  bool is_1min = true;
  int num1 = 10;

  late ZoomPanBehavior _panBehavior;
  late TrackballBehavior _trackballBehavior;
  @override
  void initState() {
    print("hello" + widget.state.poolType);

    _panBehavior = ZoomPanBehavior(
      zoomMode: ZoomMode.x,
      enableDoubleTapZooming: true,
      enablePinching: true,
      enableSelectionZooming: true,
    );
    _trackballBehavior = TrackballBehavior(
        enable: true,
        tooltipSettings: InteractiveTooltip(enable: true, color: Colors.red));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    super.initState();
  }

  void dispose() {
    // channel_m1.sink.close();
    // channel_m2.sink.close();
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _portraitState = context.findAncestorStateOfType<_g1newState>();
    if (_portraitState != null) {
      print("manual dispose");
      _portraitState.dispose();
    }
    final deviceOrientation = MediaQuery.of(context).orientation;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return deviceOrientation == Orientation.portrait
              ? ShowCaseWidget(
                  builder: Builder(builder: (context) {
                    return potraitChart(
                      dn: widget.dn,
                      data: widget.data,
                      token: widget.token,
                      state: widget.state, 
                    );
                  }),
                )
              : LandScapeChart(
                  dn: widget.dn,
                  data: widget.data,
                  token: widget.token,
                );
        },
      ),
    );
  }
}

Future setL() async {
  return await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  ;
}

Future setP() async {
  return await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

Widget chart111(List<ChartData> getChart, context, String dis_name,
    String token, minX, maxX, lastCandle) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return Row(
    children: [
      Container(
        height: 0.8 * h,
        width: 0.7 * w,
        child: SfCartesianChart(
          // trackballBehavior: _trackballBehavior,
          plotAreaBorderColor: Color.fromARGB(255, 17, 19, 31),
          series: <CandleSeries>[
            CandleSeries<ChartData, DateTime>(
                enableSolidCandles: true,
                dataSource: getChart,
                xValueMapper: (sal, _) => sal.dateTime,
                lowValueMapper: (ChartData sale, _) => sale.Low,
                highValueMapper: (ChartData sale, _) => sale.High,
                openValueMapper: (ChartData sale, _) => sale.Open,
                closeValueMapper: (ChartData sale, _) => sale.Close,
                // bearColor: Color.fromARGB(255, 255, 0, 0),
                // bullColor: Color.fromARGB(255, 0, 255, 102)
                ),
          ],
          primaryXAxis: DateTimeAxis(
            // axisLabelFormatter: (axisLabelRenderArgs) => ,
            minimum: DateTime.fromMillisecondsSinceEpoch(
              minX,
            ),
            maximum: DateTime.fromMillisecondsSinceEpoch(maxX),

            edgeLabelPlacement: EdgeLabelPlacement.shift,
            borderColor: Color.fromARGB(255, 255, 255, 255),
            axisLine: AxisLine(width: 4),
            majorGridLines: MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            borderColor: Colors.white,
            axisLine: AxisLine(width: 4),
            interactiveTooltip: InteractiveTooltip(
              enable: true,
              borderColor: Colors.red,
            ),
            // maximum: 17000,
            // minimum: 16500,
            majorGridLines: MajorGridLines(width: 0),
          ),
          // zoomPanBehavior: _panBehavior,
          backgroundColor: Color.fromARGB(255, 17, 19, 31),
        ),
      ),
      Spacer(),
      Container(
        margin: EdgeInsets.fromLTRB(0, 0.03 * h, 0, 0.09 * h),
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                MyWidget(
                    dn: dis_name,
                    token: token,
                    time_int: 60,
                    lastCandle: lastCandle),
                SizedBox(
                  width: 20,
                ),
                MyCandle(
                    dn: dis_name,
                    token: token,
                    time_int: 120,
                    lastCandle: lastCandle),
                SizedBox(
                  width: 20,
                ),
                MyWidget(
                    dn: dis_name,
                    token: token,
                    time_int: 180,
                    lastCandle: lastCandle),
              ],
            ),
          ],
        ),
      ),
      Spacer(),
    ],
  );
}
