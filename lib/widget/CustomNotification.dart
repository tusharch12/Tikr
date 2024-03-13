import 'package:flutter/material.dart';

class CustomMessageDisplay {
  BuildContext context;

  CustomMessageDisplay(this.context);

  void showMessage(String message) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        // top: 0.9 * h,
        left: 0,
        right: 0,
        bottom: 1,
        child: Container(
          height: 0.05 * h,
          color: Colors.white,
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 0.032 * w,
                fontFamily: 'Poppins',
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);

    Future.delayed(Duration(milliseconds: 1200)).then((value) {
      overlayEntry.remove();
    });
  }
}

class CustomMessageDisplay1 {
  BuildContext context;

  CustomMessageDisplay1(this.context);

  void showMessage1(String message) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        // top: 0.88 * h,
        left: 0,
        right: 0,
        bottom: 1,
        child: Container(
          height: 30.0,
          color: Colors.white,
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 0.032 * h,
                fontFamily: 'Poppins',
                decoration: TextDecoration.none,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
    overlayState.insert(overlayEntry);

    Future.delayed(Duration(seconds: 3)).then((value) {
      overlayEntry.remove();
    });
  }
}
