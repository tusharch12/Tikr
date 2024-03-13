import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/button.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:http/http.dart' as http;

import '../../widget/CustomNotification.dart';
import '../../widget/signUpButton.dart';
import '../Pool page/Pool_Page.dart';

Future ply_detail(String token, String poolCode) async {
  final String getProfileBalanceURL =
      "http://34.204.28.184:8000/get_pool_players";
  var client = http.Client();
  var input = Map<String, dynamic>();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3OTU2NDAxOH0.Hmn_jvmRSOyxenf81xDg-8NTcY6O3vkw4xV0zPbW1M4";
  input['pool_code'] = poolCode;
  var res = await client.post(Uri.parse(getProfileBalanceURL),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: input);

  var data = jsonDecode(res.body);

  return data;
}

class poolPlayers extends StatefulWidget {
  poolPlayers(
      {required this.token,
      required this.pool_name,
      required this.pool_code,
      super.key});
  String pool_name;
  String pool_code;
  String token;

  @override
  State<poolPlayers> createState() => _poolPlayersState();
}

class _poolPlayersState extends State<poolPlayers> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: Color.fromARGB(255, 25, 6, 30),
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 0.6 * h,
        decoration: BoxDecoration(
            // color: Color.fromARGB(255, 25, 6, 30),
            border: Border.all(width: 1, color: Colors.white),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(horizontal: 0.04 * w),

        // height: 100,
        child: Column(
          children: [
            SizedBox(
              height: 0.01 * h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  widget.pool_name,
                  style: ResponsiveTextStyle.get(context),
                ),
                Spacer(),
                ZoomTapAnimation(
                    onTap: () {
                      // HapticFeedback.lightImpact();
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(Images.cross))
              ],
            ),
            SizedBox(),
            FutureBuilder(
                future: ply_detail(widget.token, widget.pool_code),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var res = snapshot.data;
                    print(snapshot.data);
                    if (res['auth'] == true) {
                      // print(res['data']['all_players'][0]);
                      List ph = [];
                      ph = res['data']['all_players'];
                      print(ph);
                      // return Text("123344");
                      return ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: 0.4 * h, maxHeight: 0.45 * h),
                        child: ListView.builder(
                            itemCount: ph.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.fromLTRB(
                                    0, 0.01 * h, 0.0010 * w, 0),
                                height: 0.07 * h,
                                width: 0.9 * w,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 0.026 * w,
                                    ),
                                    SvgPicture.asset(
                                      Images.players,
                                      // color: Color.fromARGB(255, 194, 152, 0),
                                      height: 0.05 * h,
                                      width: 0.1 * w,
                                    ),
                                    // SvgPicture.asset("assests/homee.svg"),
                                    SizedBox(
                                      width: 0.02 * w,
                                    ),
                                    Text(ph[index],
                                        style: ResponsiveTextStyle.poolPlayer(
                                            context)),
                                    Spacer(),

                                    SizedBox(
                                      width: 0.02 * w,
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: GradientBoxBorder(
                                        width: 1,
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
                                        Color.fromARGB(255, 18, 66, 60),
                                        Color.fromARGB(0, 18, 66, 60),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    )),
                              );
                            }),
                      );
                    } else {
                      return SignUpButton(w, h);
                    }
                  } else
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                }),
            Spacer(),
            SizedBox(
              height: 0.01 * h,
            ),
            ZoomTapAnimation(
                onTap: () async {
                  HapticFeedback.lightImpact();

                  var res = await Join_pool(widget.pool_code, widget.token);

                  var res_body = jsonDecode(res.body);

                  Future.delayed(Duration(milliseconds: 700), () {
                    Navigator.pop(context);

                    CustomMessageDisplay customMessageDisplay =
                        CustomMessageDisplay(context);
                    customMessageDisplay.showMessage(res_body["msg"]);
                  });
                },
                child: Button(title: 'Join Now')),
            SizedBox(
              height: 0.01 * h,
            )
            // Spacer()
          ],
        ),
      ),
    );
  }
}
