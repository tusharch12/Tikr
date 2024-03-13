import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tikr/Services/secureData.dart';
import 'package:tikr/widget/Images.dart';
import 'package:tikr/widget/button.dart';
import 'package:tikr/widget/textstyle.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../theme/decoration.dart';
import '../../widget/CustomNotification.dart';

class ticketSize extends StatefulWidget {
  ticketSize({required this.token, required this.def_val});
  String token;
  var def_val;
  @override
  State<ticketSize> createState() => _ticketSizeState();
}

class _ticketSizeState extends State<ticketSize> {
  late userpro _data;
  TextEditingController _namecontoller = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _birthday = TextEditingController();
  TextEditingController _state = TextEditingController();
  int ticket_size = 1;
  @override
  void initState() {
    print("defVal: " + widget.def_val);
    ticket_size = int.tryParse(widget.def_val)!;

    super.initState();
  }

  var auth;

  int select_val = 1;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 17, 19, 31),
        body: SafeArea(
          minimum: EdgeInsets.fromLTRB(0, 0.07 * h, 0, 0),
          child: Column(
            children: [
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
                            Images.back,
                            height: 0.041 * h,
                            width: 0.041 * w,
                          )),
                    ),
                    // Spacer(),
                    Center(
                        child: Text(
                      "Ticket Size",
                      textAlign: TextAlign.center,
                      style: ResponsiveTextStyle.header(context),
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 0.03 * h,
              ),

              Center(
                  child: Text(
                "Choose the default ticket size for your purchases",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFFDCDDE9),
                  fontSize: MediaQuery.of(context).size.width * 0.045,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.normal,
                ),
              )),
              SizedBox(
                height: 0.03 * h,
              ),
              // 1 - ticket
              ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ticket_size = 1;
                  },
                  child: container(context, h, w, "1", "2", widget.def_val)),

              SizedBox(
                height: 0.013 * h,
              ),
              // 2 -ticket
              ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ticket_size = 2;
                  },
                  child: container(context, h, w, "2", "4", widget.def_val)),

              SizedBox(
                height: 0.013 * h,
              ),
              //3-ticket
              ZoomTapAnimation(
                onTap: () {
                  HapticFeedback.lightImpact();
                  ticket_size = 5;
                },
                child: container(context, h, w, '5', '10', widget.def_val),
              ),
              //4 - ticket
              SizedBox(
                height: 0.013 * h,
              ),
              ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ticket_size = 10;
                  },
                  child: container(context, h, w, '10', '20', widget.def_val)),
              SizedBox(
                height: 0.013 * h,
              ),

              //
              ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ticket_size = 25;
                  },
                  child: container(context, h, w, '25', '50', widget.def_val)),
              //
              SizedBox(
                height: 0.013 * h,
              ),

              ZoomTapAnimation(
                onTap: () {
                  HapticFeedback.lightImpact();
                  ticket_size = 50;
                },
                child: container(context, h, w, '50', '100', widget.def_val),
              ),

              SizedBox(
                height: 0.013 * h,
              ),

              ZoomTapAnimation(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ticket_size = 100;
                  },
                  child:
                      container(context, h, w, '100', '200', widget.def_val)),
              Spacer(),
              ZoomTapAnimation(
                  onTap: () {
                    saveData().setTickVal(ticket_size);
                    CustomMessageDisplay customMessageDisplay =
                        CustomMessageDisplay(context);
                    customMessageDisplay.showMessage("Successfully set ticket");
                    Get.back();
                  },
                  child: Button(title: "save")),
              SizedBox(
                height: 0.03 * h,
              )
            ],
          ),
        ));
  }
}

Container container(context, h, w, String ticket, value, String defVal) {
  return Container(
    height: 0.065 * h,
    width: 0.9 * w,
    child: Row(
      children: [
        SizedBox(
          width: 0.1 * w,
        ),
        Text(ticket + " ticket",
            style: ResponsiveTextStyle.ticketSize(context)),
        Spacer(),
        GradientText(
          "\u{20B9} " + value,
          style: ResponsiveTextStyle.ticketSize(context),
          // style: TextStyle(
          //   fontSize: 0.04 * w,
          //   fontFamily: 'Poppins',
          //   fontWeight: FontWeight.w700,
          // ),
          colors: [
            Color.fromARGB(255, 220, 185, 0),
            Color.fromARGB(255, 212, 225, 88),
          ],
        ),
        SizedBox(
          width: 0.08 * w,
        )
      ],
    ),
    decoration: ticket == defVal ? decoration_border() : decoration(),
  );
}

class userProfile {
  String msg;
  bool auth;
  Map<String, String> data;

  userProfile({required this.msg, required this.auth, required this.data});

  factory userProfile.fromJson(Map<String, dynamic> json) {
    return userProfile(msg: json["msg"], auth: json["auth"], data: {
      "email": json["data"]["email"],
      "name": json["data"]["name"],
      "birthday": json["data"]["birthday"],
      "state": json["data"]["state"],
    });
  }
}

class userpro {
  String phone_no;
  String email;
  String name;
  String birthday;
  String state;

  userpro(
      {required this.phone_no,
      required this.email,
      required this.name,
      required this.birthday,
      required this.state});

  factory userpro.fromJson(Map<String, dynamic> json) {
    return userpro(
      phone_no: json["phone_no"],
      email: json["email"],
      name: json["name"],
      birthday: json["birthday"],
      state: json["state"],
    );
  }
}
