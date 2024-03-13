import 'dart:async';

import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../Modals/StockChart/StockpriceList_modal.dart';

class CandlestickPainter extends CustomPainter {
  List<ChartData> data;
  var lastCandle;
  // var width1;
  double marginBetweenCandles = 4;
  double yAxisWidth = 30; // Increased width to accommodate price label
  double xAxisHeight = 20; // Height to accommodate date label
  double rightPadding = 40;
  double candleOffset = 20;
  CandlestickPainter(this.data, this.lastCandle);

  @override
  void paint(Canvas canvas, Size size) {
    // lastCandle = lastCandle + 60000;
    DateTime now = DateTime.now();
    int timestampInSeconds = (now.millisecondsSinceEpoch).round();
    var seconds = lastCandle - timestampInSeconds;
    seconds = (seconds / 1000).toInt();
    // print(seconds);
    if (seconds < 0) {
      seconds = 0;
    }
    var highest =
        (data.reduce((curr, next) => curr.High > next.High ? curr : next).High)
                .toInt() +
            1;
    var lowest =
        (data.reduce((curr, next) => curr.Low < next.Low ? curr : next).Low)
                .toInt() -
            1;
    if (lowest < 0) lowest = 0;
    var diff = highest - lowest;
    var mid = (highest + lowest) / 2;
//candle width
    var candleWidth = ((size.width - yAxisWidth - rightPadding) -
            marginBetweenCandles * (data.length - 1)) /
        data.length;

// Paint axes
    var axisPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.5;

// x-axis
    canvas.drawLine(Offset(yAxisWidth, size.height - xAxisHeight),
        Offset(size.width, size.height - xAxisHeight), axisPaint);

// Calculate the scaling factor for price values
    var scaleY = (size.height - xAxisHeight) / diff;

// Draw y-axis labels
    var textStyle = TextStyle(
      color: Colors.white,
      fontSize: candleWidth / 4 + 3,
    );

    var labelCount = 3; // Number of labels to show on the y-axis
    var labelStep =
        diff / (labelCount - 1); // Calculate the step size between labels

//loop for shown price at y -axis
    for (int i = 0; i < labelCount; i++) {
      var labelPrice = lowest + (labelStep * i);
      var labelY = size.height - xAxisHeight - (labelPrice - lowest) * scaleY;

      TextSpan span = TextSpan(text: labelPrice.toString(), style: textStyle);
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.right,
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout();
      // print(tp.height);

      var labelOffsetY = labelY - tp.height / 2;
      // Adjust labelOffsetY if it extends beyond the chart bounds
      if (labelOffsetY < 0) {
        labelOffsetY = 0;
      } else if (labelOffsetY + tp.height > size.height - xAxisHeight) {
        labelOffsetY = size.height - xAxisHeight - tp.height;
      }

      tp.paint(canvas, Offset(yAxisWidth - tp.width - 4, labelOffsetY));
    }

    var xTextStyle = TextStyle(
      color: Colors.white,
      fontSize: (candleWidth / 4) + 2,
    );

//loop for x-axis to render date time

    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastCandle);
    for (int i = 0; i <= data.length;) {
      var candle = i == data.length ? data[i - 1] : data[i];
      var time = i == data.length
          ? DateFormat('HH:mm').format(dateTime)
          : DateFormat('HH:mm').format(candle.dateTime);
      var x = yAxisWidth +
          // marginBetweenCandles +
          (candleWidth + marginBetweenCandles) * i;

      TextSpan xSpan = TextSpan(text: time.toString(), style: xTextStyle);
      TextPainter xTp = TextPainter(
        text: xSpan,
        textAlign: TextAlign.center,
        textDirection: ui.TextDirection.ltr,
      );
      xTp.layout();

      var labelOffsetX = x - xTp.width / 2;

      // Adjust labelOffsetX if it extends beyond the chart bounds
      if (i > 0 && labelOffsetX < x - candleWidth / 2) {
        labelOffsetX = x - candleWidth / 2;
      } else if (labelOffsetX + xTp.width > size.width) {
        labelOffsetX = x + candleWidth - xTp.width;
      }
      var candleCenterX = yAxisWidth +
          i * (candleWidth + marginBetweenCandles) +
          candleWidth / 2;

      labelOffsetX = candleCenterX - xTp.width / 2;
      var labelOffsetY = size.height - xAxisHeight + 4;

      xTp.paint(canvas, Offset(labelOffsetX, labelOffsetY));
      if (i == data.length - 1)
        i = i + 1;
      else
        i = i + 2;
      // Paint the label within the adjusted labelOffsetX
    }

// this loop for draw candle bars
    for (int i = 0; i < data.length; i++) {
      var datum = data[i];
      var highY = size.height -
          xAxisHeight -
          (size.height - xAxisHeight) * ((datum.High - lowest) / diff);
      var lowY = size.height -
          xAxisHeight -
          (size.height - xAxisHeight) * ((datum.Low - lowest) / diff);
      var openY = size.height -
          xAxisHeight -
          (size.height - xAxisHeight) * ((datum.Open - lowest) / diff);
      var closeY = size.height -
          xAxisHeight -
          (size.height - xAxisHeight) * ((datum.Close - lowest) / diff);
      var rect;
      // Candle body
      if (openY == closeY) {
        var newOpen = openY * 1.01;
        var newClose = closeY * 0.99;
        rect = Rect.fromLTRB(
            yAxisWidth +
                // marginBetweenCandles +
                i * (candleWidth + marginBetweenCandles),
            newOpen,
            yAxisWidth + i * (candleWidth + marginBetweenCandles) + candleWidth,
            newClose);
      } else {
        if (i == data.length - 2) {
          rect = Rect.fromLTRB(
              yAxisWidth +
                  // candleOffset +
                  i * (candleWidth + marginBetweenCandles) -
                  2,
              openY,
              yAxisWidth + i * (candleWidth + marginBetweenCandles)
              // candleWidth +
              ,
              closeY);
          // dottedRec(canvas, rect, 4, 5);
        } else {
          rect = Rect.fromLTRB(
              yAxisWidth + i * (candleWidth + marginBetweenCandles),
              openY,
              yAxisWidth + i * (candleWidth + marginBetweenCandles),
              // candleWidth,
              closeY);
        }
      }

      // Define the gradient colors

      var gradientColors = datum.Open < datum.Close
          ? [
              const Color.fromARGB(0, 255, 0, 0),
              Color.fromARGB(255, 255, 0, 0) ?? Colors.green
            ]
          : [
              Color.fromARGB(255, 112, 255, 0) ?? Colors.green,
              Color.fromARGB(0, 112, 255, 0) ?? Colors.green
            ];

      // Create the gradient
      var gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: gradientColors,
      );

      // Create a paint with gradient
      var paint = Paint()..shader = gradient.createShader(rect);
      if (openY == closeY) {
        canvas.drawRect(rect, Paint()..color = Colors.white);
      } else
        canvas.drawRect(rect, paint);
      // Calculate the center position of the candle
      var candleCenterX = yAxisWidth +
          i * (candleWidth + marginBetweenCandles) +
          candleWidth / 2;

      // Calculate the top and bottom positions of the wick
      var wickTopY = math.min(openY, closeY);
      var wickBottomY = math.max(openY, closeY);

// Draw the upper wick
      // if (datum.Open != datum.Close)
      canvas.drawLine(
        Offset(candleCenterX, highY),
        Offset(candleCenterX, wickTopY),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1.5,
      );

// Draw the lower wick
      // if (datum.Open != datum.Close)
      canvas.drawLine(
        Offset(candleCenterX, wickBottomY),
        Offset(candleCenterX, lowY),
        Paint()
          ..color = Colors.white
          ..strokeWidth = 1.5,
      );

// Draw the candlestick body
      if (datum.Open != datum.Close)
        canvas.drawRect(
          Rect.fromLTRB(
            yAxisWidth + i * (candleWidth + marginBetweenCandles),
            wickTopY,
            yAxisWidth + i * (candleWidth + marginBetweenCandles) + candleWidth,
            wickBottomY,
          ),
          paint,
        );
    }
/////////////
    // y-axis
    canvas.drawLine(Offset(yAxisWidth, 0),
        Offset(yAxisWidth, size.height - xAxisHeight), axisPaint);
    // var chartWidth = size.width - yAxisWidth - rightPadding;

    var additionalCandleY = size.height / 2;

    var candleHeight = 0.19 * size.height;

    var rect = Rect.fromLTRB(
        yAxisWidth +
            9 * (candleWidth + marginBetweenCandles + 0.01 * candleWidth),
        additionalCandleY - candleHeight - 20,
        yAxisWidth + 9 * (candleWidth + marginBetweenCandles) + candleWidth,
        additionalCandleY + candleHeight);
    final gradientPaint = Paint()
      ..strokeWidth = 1.5
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.green, Colors.white],
        stops: [0.0, 1.0],
      ).createShader(rect);
    // Dotted candle
    dottedRec(
        canvas, rect, 0.045 * candleHeight, 0.05 * candleHeight, gradientPaint);

    var text = seconds.toString();
    var textStyle1 = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    var textSpan = TextSpan(
      text: text,
      style: textStyle1,
    );
    var textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    textPainter.layout();

// Calculate the center position of the text within the rectangle
    var textX = rect.center.dx - textPainter.width / 2;
    var textY = rect.center.dy - textPainter.height / 2;

    textPainter.paint(canvas, Offset(textX, textY));
  }

  void dottedRec(canvas, rect, dashWidth, dashSpace, gradientPiant) {
    // var dashWidth = 9;
    // var dashSpace = 5;
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (double startX = rect.left;
        startX < rect.right;
        startX += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(startX, rect.top),
        Offset(startX + dashWidth, rect.top),
        gradientPiant,
      );
    }

    for (double startY = rect.top;
        startY < rect.bottom;
        startY += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(rect.left, startY),
        Offset(rect.left, startY + dashWidth),
        gradientPiant,
      );
    }

    for (double startX = rect.left;
        startX < rect.right;
        startX += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(startX, rect.bottom),
        Offset(startX + dashWidth, rect.bottom),
        gradientPiant,
      );
    }

    for (double startY = rect.top;
        startY < rect.bottom;
        startY += dashWidth + dashSpace) {
      canvas.drawLine(
        Offset(rect.right, startY),
        Offset(rect.right, startY + dashWidth),
        gradientPiant,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class customChart extends StatefulWidget {
  List<ChartData> data;
  var lastCandle;
  customChart({required this.data, required this.lastCandle, super.key});

  @override
  State<customChart> createState() => _customChartState();
}

class _customChartState extends State<customChart> {
  @override
  late Timer _timer;
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: Container(
        height: 0.49 * h,
        width: 0.9 * w,
        child: CustomPaint(
          painter: CandlestickPainter(widget.data, widget.lastCandle),
        ),
      ),
    );
  }
}
