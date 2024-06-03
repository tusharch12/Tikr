import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:tikr/Page/Wallet/Add_money.dart';
import 'package:tikr/widget/Images.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:tikr/widget/textstyle.dart';
import 'Recharge_Request.dart';
import 'coupun.dart';

class withdraw extends StatefulWidget {
  withdraw({Key? key, required this.token}) : super(key: key);
  String token;
  @override
  State<withdraw> createState() => _withdrawState();
}

class _withdrawState extends State<withdraw> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 17, 19, 31),
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
                            Images.back,
                            height: 0.041 * h,
                            width: 0.041 * w,
                          )),
                    ),
                    // Spacer(),
                    Center(
                        child: Text(
                      "Withdraw",
                      textAlign: TextAlign.center,
                      style: ResponsiveTextStyle.header(context),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03 * h,
              ),
              ZoomTapAnimation(
                onTap: () async {
                  var response =
                      await AddbalanceCall(widget.token, "onlinepayment");

                  Get.to(
                      () => rechargeReq(
                          link: response["body"]["data"]["Link"],
                          res: response),
                      transition: Transition.noTransition);
                },
                child: Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                    height: 0.12 * h,
                    width: 0.9 * w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: GradientBoxBorder(
                            width: 0.7,
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 137, 137, 137),
                                Color.fromARGB(0, 0, 0, 0),
                                // Color.fromARGB(255, 30, 32, 51)
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                            )),
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 54, 40, 25),
                            Color.fromARGB(0, 30, 32, 51),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 0.02 * h),
                        SvgPicture.asset(Images.Bank_transfer,
                            height: 0.05 * h),
                        SizedBox(
                          width: 0.02 * h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Bank Transfer',
                                style: ResponsiveTextStyle.get(context)),
                            Container(
                              width: 0.6 * w,
                              child: Wrap(children: [
                                Text(
                                    'Enter your complete bank details to receive your winnings within 3 days!',
                                    style:
                                        ResponsiveTextStyle.regular(context)),
                              ]),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 0.01 * w,
                        )
                      ],
                    )),
              ),
              ZoomTapAnimation(
                onTap: () {
                  Get.to(() => coupons(token: widget.token));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.fromLTRB(0, 0, 0.0010 * w, 0),
                  height: 0.12 * h,
                  width: 0.9 * w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: GradientBoxBorder(
                          width: 0.7,
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(255, 137, 137, 137),
                              Color.fromARGB(0, 0, 0, 0),
                              // Color.fromARGB(255, 30, 32, 51)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomCenter,
                          )),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(255, 54, 40, 25),
                          Color.fromARGB(0, 30, 32, 51),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 0.02 * h),
                      SvgPicture.asset(Images.cash_rewards, height: 0.05 * h),
                      SizedBox(
                        width: 0.02 * h,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Cash Rewards',
                                style: ResponsiveTextStyle.get(context)),
                            Container(
                              width: 0.6 * w,
                              child: Wrap(children: [
                                Text(
                                    'Instantly redeem your winnings from a variety of options! ',
                                    style:
                                        ResponsiveTextStyle.regular(context)),
                              ]),
                            )
                          ]),
                    ],
                  ),
                ),
              )
            ])));
  }
}
