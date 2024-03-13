import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:tikr/Modals/Pools/PublicPool_modal.dart';
import 'package:tikr/Page/Search%20page/listpp.dart';
import 'package:tikr/page/signIn.dart';
import 'package:tikr/provider/searchPool.dart';
import 'package:tikr/theme/decoration.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../Wallet/WalletPage.dart';

Future pub_pool(String token) async {
  final String getProfileBalanceURL =
      "http://34.204.28.184:8000/getall_public_pools";
  var client = http.Client();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY3OTU2NDAxOH0.Hmn_jvmRSOyxenf81xDg-8NTcY6O3vkw4xV0zPbW1M4";
  var res = await client.post(
    Uri.parse(getProfileBalanceURL),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  var data = jsonDecode(res.body);

  return res;
}



class searchPage extends StatefulWidget {
  searchPage({super.key, required this.token});
  String token;
  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    final provider = Provider.of<searchPool>(context, listen: false);
    provider.call(widget.token);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final provider = Provider.of<searchPool>(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: Stack(
        children: [
          SafeArea(
            minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                  child: Row(
                    children: [
                      ZoomTapAnimation(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            Get.to(() => wallt(token: widget.token));
                          },
                          child: SvgPicture.asset(
                            Images.wallet,
                            height: 0.041 * h,
                            width: 0.041 * w,
                          )),
                      Spacer(),
                      Consumer<searchPool>(builder: (context, provider, child) {
                        // final provider =
                        //     Provider.of<searchPool>(context, listen: false);
                        return Container(
                          height: 0.041 * h,
                          width: 0.8 * w,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 30, 32, 51),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 0.046 * w),
                              Expanded(
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  onChanged: (value) =>
                                      provider.updatelist(value),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color.fromARGB(255, 220, 221, 233),
                                    fontSize: 0.04 * w,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  // color: Color.fromARGB(255, 123, 123, 148)),
                                  decoration: InputDecoration(
                                    hintText: "Search new pools, players",
                                    fillColor: Color.fromARGB(255, 31, 32, 51),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 0.032 * w,
                                        fontFamily: 'Poppins',
                                        color:
                                            Color.fromARGB(255, 220, 221, 223)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.02 * h,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
                  child: Row(
                    children: [
                      Text('Public Pools',
                          style: TextStyle(
                              color: Color.fromARGB(255, 220, 221, 233),
                              fontSize: 0.06 * w,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600)),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.02 * h,
                ),
                Flexible(
                    child: ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 0.046 * w),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(children: [
                            Consumer<searchPool>(
                                builder: ((context, value, child) {
                              return ConstrainedBox(
                                constraints: BoxConstraints(minHeight: 0.7 * h),
                                child: Container(
                                    width: 0.9 * w,
                                    child: value.loader
                                        ? loader(context, w, h)
                                        : provider.auth
                                            ? value.mainList.isNotEmpty
                                                ? Column(
                                                    children: provider.mainList
                                                        .map(
                                                            (publicPool data) =>
                                                                listPP(
                                                                    data,
                                                                    h,
                                                                    w,
                                                                    context,
                                                                    widget
                                                                        .token))
                                                        .toList(),
                                                  )
                                                : Center(
                                                    child: Text(
                                                      value.msg,
                                                      style: TextStyle(
                                                          fontSize: 0.045 * w,
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                            : SignUpButton(w, h)),
                              );
                            })),
                          ]);
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }
}
