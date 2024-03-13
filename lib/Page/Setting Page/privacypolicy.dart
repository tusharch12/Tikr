import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:http/http.dart' as http;


Future getPrivacy() async {
  final String url = "http://34.204.28.184:8000/get_privacy_policy";
  var client = http.Client();
  var res = await client.post(
    Uri.parse(url),
    headers: {},
  );
  print("Search");
  print(res.body);
  return res.body;
}

class privacy extends StatefulWidget {
  privacy({Key? key}) : super(key: key);
  @override
  State<privacy> createState() => _privacyState();
}

class _privacyState extends State<privacy> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 0.041 * height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0.046 * width,
                      child: ZoomTapAnimation(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            Images.back,
                            height: 0.04 * height,
                            width: 0.04 * width,
                          )),
                    ),
                    Center(
                      child: Text(
                        'Privacy Policy',
                        style: ResponsiveTextStyle.header(context),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03 * height,
                width: 0.041 * width,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                      future: getPrivacy(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = jsonDecode(snapshot.data);
                          print(data);
                          return Padding(
                            padding: EdgeInsets.fromLTRB(
                                0.046 * width, 0, 0.046 * width, 0),
                            child: ListView(children: [
                              Text(
                                data["data"],
                                style: TextStyle(
                                    color: Color.fromARGB(255, 220, 221, 233),
                                    fontSize: 0.035 * width,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                            ]),
                          );
                        } else {
                          return loader(context, width, height);
                        }
                      }),
                ),
              )
            ])));
  }
}
