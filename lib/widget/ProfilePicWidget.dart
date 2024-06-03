import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_profile_picture/flutter_profile_picture.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/textstyle.dart';

import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Modals/Pools/JoinPool_modal.dart';
import '../Page/Search page/popUp.dart';
import '../page/Pool page/Pool_Page.dart';
import '../provider/pool_provider.dart';
import '../provider/searchPool.dart';
import 'CustomNotification.dart';

Widget ProfilePic(context, String token, state) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  return ZoomTapAnimation(
    onTap: () {
      HapticFeedback.lightImpact();
      Pool_popUP(context, token, state);
    },
    child: Consumer<poolProvider>(builder: (context, state, child) {
      if (state.isFlash == true) {
        Future.delayed(Duration(milliseconds: 500), () {
          state.flash_false(state.isFlash);
          print(state.isFlash);
        });
      }
      return AnimatedContainer(
        height: 0.038 * h,
        width: 0.26 * w,
        decoration: BoxDecoration(
            gradient: !state.isFlash
                ? LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                        Color.fromARGB(255, 255, 122, 0),
                        Color.fromARGB(255, 235, 51, 239)
                      ])
                : null,
            color: state.isFlash ? Colors.white : null,
            borderRadius: BorderRadius.circular(30)),
        duration: Duration(seconds: 0),
        child: FutureBuilder(
            future: state.getPool_name("pool_name"),
            builder: (context, snapshot) {
              var pn = snapshot.data;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.01 * w,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        pn.toString(),
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            fontSize: 0.03 * w,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  FutureBuilder(
                      future: state.getPool_type("pool_type"),
                      builder: (context, snapshot) {
                        var pc = snapshot.data;
                        return pc == "NA"
                            ? Container(
                                width: 0.06 * w,
                                child: ClipOval(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.asset(
                                      Images.exit_code,
                                    )
                                    //  Image(
                                    //     width: 0.071 * w,
                                    //     fit: BoxFit.cover,
                                    //     image: AssetImage(
                                    //       Images.exit_code,
                                    //     ))
                                    ),
                              )
                            : pc == "PUBLIC"
                                ? ClipOval(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: SvgPicture.asset(
                                      Images.public,
                                      fit: BoxFit.cover,
                                      width: 0.07 * w,
                                    ))
                                : ClipOval(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: SvgPicture.asset(
                                      Images.private,
                                      fit: BoxFit.cover,
                                      width: 0.07 * w,
                                    ));
                      }),
                  SizedBox(
                    width: 0.01 * w,
                  )
                ],
              );
            }),
      );
    }),
  );
}

Future<List<JoinPools>> getPool(String token) async {
  String url = "http://34.204.28.184:8000/get_pools";
  var client = http.Client();
  var Response = await client.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  Map<String, dynamic> body2 = jsonDecode(Response.body);
  List<dynamic> body1 = [];

  Map<String, dynamic> BotData = {
    'pool_name': 'BOT',
    'pool_code': 'NA',
    'no_players': 'NA'
  };
  body1.add(BotData);
  print(body2);
  if (body2['data']['pool_info'] != null &&
      body2['data']['pool_info'].isNotEmpty &&
      body2['data']['pool_info'][0].isNotEmpty) {
    body1.addAll(body2["data"]["pool_info"]);
  }

  List<JoinPools> PI =
      body1.map((dynamic item) => JoinPools.fromjson(item)).toList();

  return PI;
}

void Pool_popUP(BuildContext context, String token, state) {
  final provider = Provider.of<searchPool>(context, listen: false);
  provider.getMyPoolList(token);
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Color(0XFF1E2033),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      context: context,
      builder: (context) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          builder: ((context, scrollController) => SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.04 * width),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 0.01 * height,
                      ),
                      Container(
                        height: 0.005 * height,
                        width: 0.27 * width,
                        decoration: BoxDecoration(
                            color: Color(0XFF4D5068),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      SizedBox(
                        height: 0.02 * height,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ZoomTapAnimation(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                provider.getMyPoolList(token);
                              },
                              child: SvgPicture.asset(
                                Images.refresh,
                                height: 0.04 * height,
                                width: 0.04 * width,
                              )),
                          Spacer(),
                          Text('Your Pools',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 220, 221, 233),
                                fontSize: 0.05 * width,
                                fontWeight: FontWeight.bold,
                              )),
                          Spacer(),
                          ZoomTapAnimation(
                              onTap: () {
                                HapticFeedback.lightImpact();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => pool(token: token)));
                              },
                              child: SvgPicture.asset(
                                Images.plus,
                                height: 0.03 * height,
                                width: 0.03 * width,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 0.05 * height,
                      ),
                      Consumer<searchPool>(builder: (context, provider, child) {
                        return provider.PI.isNotEmpty
                            ? SizedBox(
                                height: 0.7 * height,
                                child: ListView.builder(
                                    itemCount: provider.PI.length,
                                    itemBuilder: (context, index) {
                                      return list11(
                                          data: provider.PI[index],
                                          provider: state,
                                          token: token);
                                    }))
                            : Center(
                                child: SpinKitThreeBounce(
                                size: 40,
                                color: Colors.white,
                              ));
                      }),
                      SizedBox(
                        height: 0.02 * height,
                      ),
                    ],
                  ),
                ),
              ))));
}

exitPool(String poolCode, String type, String token) async {
  String url = "http://34.204.28.184:8000/exit_pool";

  var map = Map<String, dynamic>();
  print(poolCode);
  map["pool_code"] = poolCode;

  var response = await http.post(Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: map);
  print(response.body);
  return response.body;
}

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
  print(data);

  return res;
}

class list11 extends StatefulWidget {
  list11(
      {super.key,
      required this.data,
      required this.provider,
      required this.token});

  var data;
  var provider;
  String token;

  @override
  State<list11> createState() => _list11State();
}

class _list11State extends State<list11> {
  bool delete = false;
  late String ch;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ch = widget.data.pool_code[0] + widget.data.pool_code[1];
    return GestureDetector(
      onLongPress: () {
        HapticFeedback.lightImpact();
        if (widget.data.pool_name != "BOT") {
          setState(() {
            delete = !delete;
          });
        }
      },
      onDoubleTap: () {
        print("12698634786387");
        ply_detail(widget.token, widget.data.pool_code);
      },
      onTap: () async {
        HapticFeedback.lightImpact();
        widget.provider
            .playertype(widget.data.pool_name == "BOT" ? "BOT" : "POOL");
        widget.provider.poolname(widget.data.pool_name);
        widget.provider.poolcode(widget.data.pool_code);

        if (ch == "NA") {
          widget.provider.pooltype("NA");
        } else if (ch == "PR") {
          widget.provider.pooltype("PRIVATE");
        } else {
          widget.provider.pooltype("PUBLIC");
        }
        widget.provider.flash_true(widget.provider.isFlash);
        // print("after calling flash true function");
        print(widget.provider.isFlash);

        Future.delayed(Duration(milliseconds: 700), () {
          Navigator.pop(context);
          CustomMessageDisplay customMessageDisplay =
              CustomMessageDisplay(context);
          customMessageDisplay.showMessage("Pool successfully selected ✅");
        });
      },
      child: IgnorePointer(
        ignoring: false,
        ignoringSemantics: true,
        child: Container(
            margin: EdgeInsets.only(bottom: 0.012 * height),
            height: 0.074 * height,
            width: 0.98 * width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0XFF363A36),
                  Color(0XFF1E2033),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              border: GradientBoxBorder(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color.fromARGB(255, 92, 95, 122),
                    Color.fromARGB(0, 0, 0, 0),
                  ])),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 0.02 * width,
                ),
                ch == "NA"
                    ? ClipOval(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          // width: 0.09 * width,
                          height: 0.05 * height,
                          fit: BoxFit.cover,
                          image: AssetImage(
                            Images.exit_code,
                          ),
                        ),
                      )
                    : ch == "PR"
                        ? ClipOval(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: SvgPicture.asset(Images.private,
                                height: 0.05 * height),
                          )
                        : ClipOval(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: SvgPicture.asset(Images.public,
                                height: 0.05 * height),
                          ),
                SizedBox(
                  width: 0.02 * width,
                ),
                Text(
                  widget.data.pool_name,
                  style: ResponsiveTextStyle.get(context),
                ),
                Spacer(),
                delete
                    ? Row(
                        children: [
                          ZoomTapAnimation(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                copyToClipboard(widget.data.pool_code);
                                await Clipboard.setData(
                                    ClipboardData(text: widget.data.pool_code));

                                CustomMessageDisplay customMessageDisplay =
                                    CustomMessageDisplay(context);
                                customMessageDisplay.showMessage(
                                    "Successfully copied pool code 👍🏻");
                              },
                              child: SvgPicture.asset(
                                Images.copy,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 0.02 * width,
                          ),
                          ZoomTapAnimation(
                              onTap: () async {
                                HapticFeedback.lightImpact();
                                // String pType = widget.data.pool_code[0] + widget.data.pool_code[1];
                                var res = await exitPool(widget.data.pool_code,
                                    "public", widget.token);
                                var res_body = jsonDecode(res);
                                Navigator.pop(context);
                                CustomMessageDisplay customMessageDisplay =
                                    CustomMessageDisplay(context);
                                customMessageDisplay
                                    .showMessage(res_body["msg"]);
                                setState(() {
                                  delete = !delete;
                                });
                                var pn = await widget.provider
                                    .getPool_name("pool_name");

                                if (pn == widget.data.pool_name) {
                                  widget.provider.playertype("BOT");
                                  widget.provider.poolname("BOT");
                                  widget.provider.poolcode("NA");
                                  widget.provider.pooltype("NA");

                                  widget.provider
                                      .flash_true(widget.provider.isFlash);
                                  print("after calling flash true function");
                                  print(widget.provider.isFlash);
                                } else {}
                                // }Navigator.pop(context);
                              },
                              child: SvgPicture.asset(Images.bot,
                                  height: 0.04 * height)),
                        ],
                      )
                    : Text(
                        widget.data.pool_name == "BOT"
                            ? "I’m Alone"
                            : widget.data.no_players == "1"
                                ? widget.data.no_players + " Player"
                                : widget.data.no_players + " Players",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 0.03 * width,
                          color: Color(0XFFDCDDE9),
                        ),
                      ),
                SizedBox(
                  width: 0.05 * width,
                ),
                SizedBox(
                  height: 0.05 * height,
                )
              ],
            )),
      ),
    );
  }
}
