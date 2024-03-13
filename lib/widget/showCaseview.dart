import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowCaseView extends StatelessWidget {
 const ShowCaseView(
    {Key?key,required this.globalKey,
                     required this.title,
                     required this.des,
                        this.shapeBoder=const CircleBorder(),
                     required this.child,}):super(key: key);
  final GlobalKey globalKey;
  final String title;
  final String des;
  final Widget child;
  final ShapeBorder shapeBoder;

  @override
  Widget build(BuildContext context) {
    return Showcase(key: 
    globalKey, title: title, description: des, child: child) ;
  }
}
