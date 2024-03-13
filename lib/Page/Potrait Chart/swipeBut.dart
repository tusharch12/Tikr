import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:swipeable_button_flutter/swipablewidget.dart';

class CustomSwipeButton extends StatefulWidget {
  /// The text that the button will display.
  final String text;

  /// with of the button
  final double height;

  /// The callback invoked when the button is swiped.
  final VoidCallback onSwipeCallback;

  final Gradient? gradient;
  final BoxBorder? border;

  /// Optional changes
  final Color swipeButtonColor;
  var backgroundColor;
  final Color iconColor;
  TextStyle? buttonTextStyle;
  final EdgeInsets padding;

  /// The decimal percentage of swiping in order for the callbacks to get called, defaults to 0.75 (75%) of the total width of the children.
  final double? swipePercentageNeeded;

  CustomSwipeButton(
      {Key? key,
      required this.text,
      this.height = 80,
      required this.onSwipeCallback,
      this.swipeButtonColor = Colors.yellow,
      this.backgroundColor = Colors.blue,
      this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
      this.iconColor = Colors.white,
      this.buttonTextStyle,
      this.swipePercentageNeeded,
      this.gradient,
      this.border})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => StateCustomSwipeButton(
        text: text,
        onSwipeCallback: onSwipeCallback,
        height: height,
        padding: this.padding,
        swipeButtonColor: this.swipeButtonColor,
        backgroundColor: this.backgroundColor,
        iconColor: this.iconColor,
        buttonTextStyle: this.buttonTextStyle,
      );
}

class StateCustomSwipeButton extends State<CustomSwipeButton> {
  /// The text that the button will display.
  final String text;
  final double height;
  final Gradient? gradient;
  final BoxBorder? boder;

  /// The callback invoked when the button is swiped.
  final VoidCallback onSwipeCallback;
  bool isSwiping = false;
  double opacityVal = 1;
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle? buttonTextStyle;
  final EdgeInsets padding;

  StateCustomSwipeButton(
      {Key? key,
      required this.text,
      required this.height,
      required this.onSwipeCallback,
      this.padding = const EdgeInsets.fromLTRB(5, 5, 5, 5),
      this.swipeButtonColor = Colors.amber,
      this.backgroundColor = Colors.black,
      this.iconColor = Colors.white,
      this.buttonTextStyle,
      this.gradient,
      this.boder});

  @override
  Widget build(BuildContext context) {
    if (buttonTextStyle == null) {
      buttonTextStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 0.04 * MediaQuery.of(context).size.width,
        fontFamily: 'Poppins',
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            decoration: BoxDecoration(
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 222, 203, 195),
                      Color.fromARGB(0, 222, 203, 195)
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  width: 1,
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 227, 51, 66),
                    Color.fromARGB(255, 182, 18, 103)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                // color: backgroundColor,
                borderRadius: BorderRadius.circular(height / 2)),
            child: new Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 0.04 * MediaQuery.of(context).size.width,
                  fontFamily: 'Poppins',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SwipeableWidget(
            height: height,
            // width: MediaQuery.of(context).size.width * 1,
            swipePercentageNeeded: widget.swipePercentageNeeded == null
                ? 0.75
                : widget.swipePercentageNeeded,
            screenSize: MediaQuery.of(context).size.width -
                (padding.right + padding.left),
            child: Container(
              margin: EdgeInsets.fromLTRB(
                height * 0.06,
                height * 0.06,
                height * 0.06,
                height * 0.06,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: _buildContent(),
              ),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  color: swipeButtonColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
            onSwipeCallback: onSwipeCallback,
            onSwipeStartcallback: (val, conVal) {
              print("isGrate $conVal");
              SchedulerBinding.instance!
                  .addPostFrameCallback((_) => setState(() {
                        isSwiping = val;
                        opacityVal = 1 - conVal;
                      }));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: EdgeInsets.only(left: height / 2),
      child: Text(
        text,
        style: buttonTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.center,
          child: AnimatedOpacity(
            opacity: (opacityVal - 0.4).isNegative ? 0.0 : (opacityVal - 0.4),
            duration: Duration(milliseconds: 10),
            child: Icon(
              Icons.chevron_right,
              color: iconColor,
              size: height * 0.6,
            ),
          ),
        ),
       
      ],
    );
  }
}

