import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loader(context , w, h) {
  return Center(
      child: Container(
    padding: EdgeInsets.fromLTRB(0.03 * w, 0, 0.03 * w, 0),
    child: Center(
        child: SpinKitThreeBounce(
      size: 40,
      color: Colors.white,
    )),
  ));
}
