import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Modals/orders/orders_modal.dart';
import '../../textstyle.dart';
import '../../widget/CustomNotification.dart';

class orderDetail extends StatefulWidget {
  orderDetail({required this.data, Key? key}) : super(key: key);
  order data;
  @override
  State<orderDetail> createState() => _orderDetailState();
}

class _orderDetailState extends State<orderDetail> {
  @override
  String formattedDate = "";
  void initState() {
    double time = double.parse(widget.data.play_time);
    print(time);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch((time * 1000).toInt());
    formattedDate = DateFormat('HH:mm a , dd MMMM yyyy').format(dateTime);
    widget.data.play_time;
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
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              height: 0.041 * h,
              //  padding: EdgeInsets.fromLTRB(0, 0.02 * h, 0, 0),
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
                          height: 0.041 * h,
                          width: 0.041 * w,
                        )),
                  ),
                  // Spacer(),
                  Center(
                      child: Text(
                    "Order",
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
            Container(
              height: 0.9 * h,
              padding: EdgeInsets.fromLTRB(0.046 * w, 0, 0.046 * w, 0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 0.04 * h,
                  ),
                  Text('Message', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: widget.data.msg));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.msg,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Game ID', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.game_id));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.game_id,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Stock Name', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                      onLongPress: () {
                        Clipboard.setData(
                            ClipboardData(text: widget.data.StockName));
                        Future.delayed(Duration(milliseconds: 700), () {
                          // Navigator.pop(context);
                          CustomMessageDisplay customMessageDisplay =
                              CustomMessageDisplay(context);
                          customMessageDisplay
                              .showMessage("Copied to clipboard");
                        });
                      },
                      child: Text(widget.data.StockName,
                          style: ResponsiveTextStyle.headline1(context))),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Interval', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.interval));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.interval,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Play Direction',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.Play_direction));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.Play_direction,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Play Time', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.play_time));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(formattedDate,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Number of Ticket(s)',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.ticket.toString()));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text("${widget.data.ticket}",
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Trade Value', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.amount.toString()));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text("${widget.data.amount}",
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Counter Trade Value (BOT)',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.counter_investment));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.counter_investment,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Counter Direction (BOT)',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.counter_direction));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.counter_direction,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Player Type', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.Player_type));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.Player_type,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Pool Type', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.pool_type));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.pool_type,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Pool Name', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.pool_name));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.pool_name,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Pool Code', style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.pool_code));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.pool_code,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Balance before purchase',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                          text: widget.data.final_double_balance.toString()));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text("${widget.data.final_double_balance}",
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Winning Amount',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                          text: widget.data.winning_amount.toString()));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text("${widget.data.winning_amount}",
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                  Text('Winning Update Status',
                      style: ResponsiveTextStyle.get(context)),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.data.balance_updated));
                      Future.delayed(Duration(milliseconds: 700), () {
                        // Navigator.pop(context);
                        CustomMessageDisplay customMessageDisplay =
                            CustomMessageDisplay(context);
                        customMessageDisplay.showMessage("Copied to clipboard");
                      });
                    },
                    child: Text(widget.data.balance_updated,
                        style: ResponsiveTextStyle.headline1(context)),
                  ),
                  SizedBox(
                    height: 0.02 * h,
                  ),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
} 
/////////////////////////abjhghgfkhgch
