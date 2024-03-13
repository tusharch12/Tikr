import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Class/simpleChartData.dart';
import '../../Modals/StockChart/StockpriceList_modal.dart';

Widget chartL(List<ChartData> getChart, context, String dis_name, String token,
    minX, maxX, lastCandle) {
  double h = MediaQuery.of(context).size.height;
  double w = MediaQuery.of(context).size.width;
  return Row(
    children: [
      Container(
        height: 0.8 * h,
        width: 0.7 * w,
        child: SfCartesianChart(
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
                bearColor: Color.fromARGB(255, 255, 0, 0),
                bullColor: Color.fromARGB(255, 0, 255, 102)),
          ],
          primaryXAxis: DateTimeAxis(
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            axisLine: AxisLine(color: Colors.white, width: 2),
            // axisLabelFormatter: (axisLabelRenderArgs) => ,
            minimum: DateTime.fromMillisecondsSinceEpoch(
              minX,
            ),
            maximum: DateTime.fromMillisecondsSinceEpoch(maxX),

            edgeLabelPlacement: EdgeLabelPlacement.shift,
            borderColor: Color.fromARGB(255, 255, 255, 255),
            // axisLine: AxisLine(width: 4),
            majorGridLines: MajorGridLines(width: 0),
          ),
          primaryYAxis: NumericAxis(
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            axisLine: AxisLine(color: Colors.white, width: 2),
            borderColor: Colors.white,
            // axisLine: AxisLine(width: 4),
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
