import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/widget/Loader.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../widget/listcarding.dart';

Future fandqApi(token) async {
  final String getprofileda = "http://34.204.28.184:8000/get_faqs";
  var client = http.Client();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY4MDQzNzE5OX0.Lof3zjEFXPKEJ7_55qVJmtBcnJ4COYVTJy3Vcaro8F0";

  var map = Map<String, dynamic>();
  var res = await client.post(Uri.parse(getprofileda),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  print(res.body);
  return res.body;
}

@override
class fandq extends StatefulWidget {
  fandq({super.key, required this.token});
  String token;

  @override
  State<fandq> createState() => _fandqState();
}

class _fandqState extends State<fandq> {
  @override
  void initState() {
    fandqApi(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
            child: Column(children: [
              Container(
                height: 0.041 * h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0.046 * w,
                      child: ZoomTapAnimation(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assests/Arrow.svg',
                            height: 0.04 * h,
                            width: 0.041 * w,
                          )),
                    ),
                    Center(
                        child: Text(
                      "FAQs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 220, 221, 233),
                        fontSize: 0.043 * w,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 0.01 * h,
              ),
              Expanded(
                child: Container(
                    // height: 0.74 * h,
                    child: FutureBuilder(
                        future: fandqApi(widget.token),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var data = jsonDecode(snapshot.data);
                            if (data["msg"] == "No Data Found") {
                              return Center(
                                child: Text(
                                  "No trade Found !",
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            } else {
                              print(data["data"]);
                              var listt = data["data"];
                              print(listt);
                              Dataa1 fattu = Dataa1.fromjson(listt);
                              return listcarding(
                                data: fattu,
                              );
                            }
                          } else {
                            return loader(context, w, h);
                          }
                        })),
              ),
            ])));
  }
}
