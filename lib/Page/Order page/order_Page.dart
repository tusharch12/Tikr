import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tikr/Modals/orders/orders_modal.dart';
import 'package:tikr/Page/Order%20page/pastOrder_Page.dart';
import 'package:tikr/Page/signIn.dart';
import 'package:tikr/widget/button.dart';

import 'package:tikr/widget/orderPage_con.dart';
import 'package:tikr/widget/signUpButton.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../provider/recentOrder.dart';
import 'package:tikr/widget/textstyle.dart';
import '../Wallet/WalletPage.dart';

Future orderApiCall(token) async {
  final String getProfileBalanceURL =
      "http://34.204.28.184:8000/get_recent_trades";
  var client = http.Client();
  // String token =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiKzkxNzc0MjQzODU5NSIsImV4cCI6MTY4MDQzNzE5OX0.Lof3zjEFXPKEJ7_55qVJmtBcnJ4COYVTJy3Vcaro8F0";
  var res = await client.post(
    Uri.parse(getProfileBalanceURL),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  // print("Search");
  // print(res.body);
  return res;
}

class orderPage extends StatefulWidget {
  orderPage({super.key, required this.token});

  String token;
  @override
  State<orderPage> createState() => _orderPageState();
}

class _orderPageState extends State<orderPage> {
  double listH = 0.7;
  String passdate = "";
  List<String> items = ["Recent", "Past"];
  TextEditingController _date = TextEditingController();
  String date = "Choose the date";
  @override
  void initState() {
    // PastOrderCall(widget.token, date);
    final provider = Provider.of<recentOrderPro>(context, listen: false);
    provider.call(widget.token);
    // orderApiCall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final provider = Provider.of<recentOrderPro>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(0, 0.07 * height, 0, 0),
        child: DefaultTabController(
            length: 2,
            child: Column(children: [
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
                            Get.to(() => wallt(token: widget.token));
                          },
                          child: SvgPicture.asset(
                            'assests/wallet.svg',
                            height: 0.041 * height,
                            width: 0.041 * width,
                          )),
                    ),
                    Positioned(
                      right: 0.046 * width,
                      child: ZoomTapAnimation(
                          onTap: () {
                            HapticFeedback.lightImpact();
                            // orderPage(token: widget.token);
                            final provider = Provider.of<recentOrderPro>(
                                context,
                                listen: false);
                            provider.call(widget.token);
                          },
                          child: SvgPicture.asset(
                            'assests/rotate1.svg',
                            height: 0.03 * height,
                            width: 0.03 * width,
                          )),
                    ),
                    Center(
                        child: Text(
                      'Orders',
                      textAlign: TextAlign.center,
                      style: ResponsiveTextStyle.header(context),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 0.02 * height,
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(0.046 * width, 0, 0.046 * width, 0),
                child: Container(
                  height: 0.05 * height,
                  width: 0.8 * width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: TabBar(
                    unselectedLabelColor: Colors.white,
                    indicatorColor: Colors.black,
                    indicator: BoxDecoration(
                        border: GradientBoxBorder(
                            gradient: LinearGradient(colors: [
                          Color.fromARGB(255, 222, 203, 195),
                          Color.fromARGB(0, 222, 203, 195)
                        ])),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 227, 51, 66),
                            Color.fromARGB(255, 182, 18, 103)
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30)),
                    tabs: [
                      Tab(
                        child: Container(
                          // height: 0.07 * height,
                          // width: 0.6 * width,
                          decoration: BoxDecoration(
                            // color: Color.fromARGB(100, 30, 32, 51),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Recent',
                              style: TextStyle(
                                fontSize: 0.035 * width,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 225, 225, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          height: 0.07 * height,
                          width: 0.6 * width,
                          decoration: BoxDecoration(
                            // color: Color.fromARGB(100, 30, 32, 51),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Past',
                              style: TextStyle(
                                fontSize: 0.035 * width,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 225, 225, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0.02 * height,
              ),
              Flexible(
                child: TabBarView(children: [
                  ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 0.046 * width),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return listw(height, width, listH);
                      }),
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(0.046 * width, 0, 0.046 * width, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: ResponsiveTextStyle.pool(context),
                        ),
                        SizedBox(
                          height: 0.01 * height,
                        ),
                        ZoomTapAnimation(
                          onTap: () async {
                            //  HapticFeedback.lightImpact();
                            DateTime date1 = DateTime.now();
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now());
                            String pickDate =
                                DateFormat("yyyy-MM-dd").format(pickeddate!);
                            setState(() {
                              date = pickDate;
                            });
                            passdate = pickDate;
                          },
                          child: Container(
                            height: 0.08 * height,
                            width: 0.9 * width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 31, 32, 51)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 0.05 * width,
                                ),
                                Text(date,
                                    style: TextStyle(
                                        fontSize: 0.038 * width,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(
                                            255, 123, 123, 148))),
                                Spacer(),
                                ZoomTapAnimation(
                                    onTap: () async {
                                      HapticFeedback.lightImpact();
                                      DateTime date1 = DateTime.now();
                                      DateTime? pickeddate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime.now());
                                      String pickDate = DateFormat("yyyy-MM-dd")
                                          .format(pickeddate!);
                                      setState(() {
                                        date = pickDate;
                                      });
                                      passdate = pickDate;
                                    },
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  width: 0.05 * width,
                                )
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        ZoomTapAnimation(
                            onTap: () async {
                              HapticFeedback.lightImpact();
                              Get.to(() => PastOrderPage(
                                  token: widget.token, passdate: passdate));
                            },
                            child: Button(title: "Look")),
                        SizedBox(
                          height: 0.02 * height,
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ])),
      ),
    );
  }
}

Widget listw(height, width, lh) {
  return Column(children: [
    Consumer<recentOrderPro>(builder: (context, value, child) {
      return ConstrainedBox(
        constraints: BoxConstraints(minHeight: lh * height),
        child: Container(
            width: 0.9 * width,
            child: value.loader
                ? value.auth
                    ? value.mainList.isNotEmpty
                        ? Column(
                            children: value.mainList
                                .map((order data) => Past_order(context, data))
                                .toList(),
                          )
                        : Center(
                            child: Text(
                              value.msg,
                              style: TextStyle(
                                  fontSize: 0.045 * width,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white),
                            ),
                          )
                    : SignUpButton(width, height)
                : loader(context, width, height)),
      );
    }),
  ]);
}
