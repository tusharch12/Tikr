import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tikr/page/Setting%20Page/FAQ.dart';

class listcarding extends StatefulWidget {
  Dataa1 data;
  listcarding({required this.data});

  @override
  State<listcarding> createState() => _listcardingState();
}

class _listcardingState extends State<listcarding> {
  List<String> name = [];
  List<String> dis = [];

  //  bool _isMenuIcon = true;
  // bool _isTapped = false;
  bool isExpanded = false;
  FontWeight _fontWeight = FontWeight.normal;

  void _onTap() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  void initState() {
    widget.data.dataMap.keys.forEach((key) {
      if (key.startsWith('Question')) {
        name.add(widget.data.dataMap[key]!);
      } else if (key.startsWith('Answer')) {
        dis.add(widget.data.dataMap[key]!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   bool _isMenuIcon = true;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // print(widget.data.Question1);
    print("mweeeee");
    print(name[0]);
    print(name[1]);
    print(dis[1]);
    return Padding(
      padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
            child: ListView.builder(
                itemCount: name.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(top: 0.02 * h),
                      // padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                      width: 0.9 * w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: GradientBoxBorder(
                              width: 0.7,
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 94, 95, 112),
                                  Color.fromARGB(0, 0, 0, 0),

                                  // Color.fromARGB(255, 30, 32, 51)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomCenter,
                              )),
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 45, 54, 46),
                              Color.fromARGB(0, 30, 32, 51),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                      child: ExpansionTile(
                          trailing: SizedBox.shrink(),
                          leading: Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                          ),
                          key: ValueKey(index),
                          iconColor: Colors.white,
                          title: Text(
                            name[index].toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0XFFDCDDE9),
                              fontSize: 0.04 * w,
                            ),
                          ),
                          onExpansionChanged: (bool expanding) => _onTap(),
                          children: [
                            Container(
                                alignment: Alignment.topLeft,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                // height: 0.06 * h,
                                child: Text(
                                  dis[index].toString(),
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0XFFDCDDE9),
                                      fontSize: 0.04 * w,
                                      fontWeight: FontWeight.w400),
                                ))
                          ]));
                })),
        SizedBox(
          height: 0.02 * h,
        ),
      ]),
    );
  }
}

class Dataa1 {
  Map<String, String> dataMap = {};

  Dataa1({required this.dataMap});

  factory Dataa1.fromjson(Map<String, dynamic> json) {
    Map<String, String> dataMap = {};
    json.keys.forEach((key) {
      dataMap[key] = json[key];
    });
    return Dataa1(dataMap: dataMap);
  }
}
