import 'dart:async';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../Class/custom_candle.dart';
import '../../Modals/StockChart/StockpriceList_modal.dart';
import '../../provider/timerCandle.dart';

Widget chartP(
    List<ChartData> getChart, context, minX, maxX, lastCandle, timerCandle) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  String dn = " ";
  String token = "";
  return Row(children: [
    Container(
      height: 0.8 * h,
      width: 0.8 * w,
      child: SfCartesianChart(
        plotAreaBorderColor: Color.fromARGB(255, 17, 19, 31),
        series: <ChartSeries>[
          CandleSeries<ChartData, DateTime>(
        
            enableSolidCandles: true,
            dataSource: getChart,
            xValueMapper: (sal, _) => sal.dateTime,
            lowValueMapper: (ChartData sale, _) => sale.Low,
            highValueMapper: (ChartData sale, _) => sale.High,
            openValueMapper: (ChartData sale, _) => sale.Open,
            closeValueMapper: (ChartData sale, _) => sale.Close,
            // renderer:
            // bearColor: Color.fromARGB(255, 255, 0, 0),
            // bullColor: Color.fromARGB(255, 0, 255, 102),
          ),
        ],
        primaryXAxis: DateTimeAxis(
          labelRotation: 90,
          minorTicksPerInterval: 0,
          intervalType: DateTimeIntervalType.auto,
          enableAutoIntervalOnZooming: true,
          zoomPosition: 1.0, name: "date",
          
          axisLine: AxisLine(color: Colors.white, width: 2),
          labelStyle: TextStyle(
            color: Colors.white,
          ),

          // axisLabelFormatter: (axisLabelRenderArgs) => ,
          // minimum: DateTime.fromMillisecondsSinceEpoch(minX),
          majorTickLines: MajorTickLines(size: 5),
          minorTickLines: MinorTickLines(size: 5),

          maximum: DateTime.fromMillisecondsSinceEpoch(maxX),
          maximumLabels: 7,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          borderColor: Color.fromARGB(255, 255, 255, 255),
          // axisLine: AxisLine(width: 1),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          axisLine: AxisLine(color: Colors.white, width: 2),
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          majorGridLines: MajorGridLines(width: 0),
        ),
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
      ),
    ),
    Container(
      margin: EdgeInsets.fromLTRB(0, 0.013 * h, 0, 0.042 * h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          boxRed(LastCandle: lastCandle, tCandle: timerCandle),
        ],
      ),
    )
  ]);
}

class boxRed extends StatefulWidget {
  boxRed({super.key, required this.LastCandle, required this.tCandle});
  var LastCandle;
  var tCandle;
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
    widget.LastCandle = 0;
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
                        return Showcase(
                          key: widget.tCandle,
                          description:
                              "Predict this future candle for your chosen interval 📊",
                          child: RotatedBox(
                            quarterTurns: 45,
                            child: Center(
                              child: Text(
                                "${value.seconds}  sec",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }))));
        }));
  }
}
