import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:http/http.dart' as http;
import 'package:tikr/button.dart';
import 'package:tikr/page/Setting%20Page/privacypolicy.dart';
import 'package:tikr/page/Setting%20Page/termsndcondition.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../widget/CustomNotification.dart';
import 'otp.dart';

class SendPh {
  final String postUrlSendPh = "http://34.204.28.184:8000/login_request";
  var map = Map<String, dynamic>();
  Future postPh(countryCode, phone) async {
    map["country"] = countryCode;
    map["phone"] = phone;
    final response =
        await http.post(Uri.parse(postUrlSendPh), headers: {}, body: map);
    var map1 = Map<String, dynamic>();
    map1["status"] = response.statusCode;
    map1["body"] = jsonDecode(response.body);
    print(map1);
    return map1;
  }
}

class signin1 extends StatefulWidget {
  signin1({Key? key}) : super(key: key);
  @override
  State<signin1> createState() => _signin1State();
}

class _signin1State extends State<signin1> {
  TextEditingController countrycode = TextEditingController();
  var Phone = '';
  String countrycode1 = '';

  Future siginv() async {
    var data = await SendPh().postPh(countrycode1, Phone.toString());
    var msg = data["body"]["msg"];
    if (data["status"] == 200) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => otp1(
                cntyCode: countrycode1,
                phone: Phone,
              )));
    } else {
      CustomMessageDisplay customMessageDisplay = CustomMessageDisplay(context);
      customMessageDisplay.showMessage(msg);
    }
  }

  @override
  void initState() {
    countrycode1 = '+91';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // Display content in a Column on smaller screens
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 17, 19, 31),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.045,
          ),
          child: Container(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 0.04 * height),
              Text(
                'Sign In',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color.fromARGB(255, 223, 221, 233),
                    fontSize: 0.065 * width,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 0.022 * height,
              ),
              Text(
                'Simply enter your phone number and start trading!',
                style: TextStyle(
                  fontSize: 0.043 * width,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w300,
                  color: Color.fromARGB(255, 122, 124, 143),
                ),
              ),
              SizedBox(
                height: 0.03 * height,
              ),
              Text(
                'Phone',
                style: TextStyle(
                    fontSize: 0.028 * width,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 123, 123, 148)),
              ),
              SizedBox(height: 0.01 * height),
              Container(
                height: 0.098 * height,
                width: 0.9 * width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 30, 32, 51),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 0.05 * width,
                    ),
                    Center(
                        child: Image.asset(
                      'assests/india.png',
                      width: 0.07 * width,
                      // height: 0.1 * height
                    )),
                    //  Image.asset(Images.Group5),
                    SizedBox(width: 0.04 * width),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Spacer(),
                        Container(
                            // color: Colors.amber,
                            // color: Colors.amberAccent,
                            width: 0.08 * width,
                            child: Text(
                              countrycode1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 0.04 * width,
                                  color: Color.fromARGB(255, 123, 123, 148)),
                            )),
                        // ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(
                      width: 0.02 * width,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          autofocus: true,
                          onEditingComplete: siginv,
                          onChanged: ((value) {
                            Phone = value;
                          }),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 0.04 * width,
                              color: Color.fromARGB(255, 123, 123, 148)),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 123, 123, 148)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 0.0285 * height,
              ),
              Row(
                children: [
                  Text('By continuing, you agree to the ',
                      style: TextStyle(
                          fontSize: 0.039 * width,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 255, 255, 255))),
                ],
              ),
              Row(
                children: [
                  ZoomTapAnimation(
                    onTap: () => Get.to(() => terms()),
                    child: Text('Terms & Conditions ',
                        style: TextStyle(
                            fontSize: 0.039 * width,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w200,
                            color: Color.fromARGB(255, 36, 201, 171))),
                  ),
                  Text('and',
                      style: TextStyle(
                          fontSize: 0.039 * width,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  ZoomTapAnimation(
                    onTap: () {
                      Get.to(() => privacy());
                    },
                    child: Text(' Privacy Policy.',
                        style: TextStyle(
                            fontSize: 0.039 * width,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w200,
                            color: const Color.fromARGB(255, 36, 201, 171))),
                  ),
                ],
              ),
              Spacer(),
              ZoomTapAnimation(
                  onTap: () async {
                    var data =
                        await SendPh().postPh(countrycode1, Phone.toString());
                    var msg = data["body"]["msg"];
                    if (data["status"] == 200) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => otp1(
                                cntyCode: countrycode1,
                                phone: Phone,
                              )));
                    } else {
                      CustomMessageDisplay customMessageDisplay =
                          CustomMessageDisplay(context);
                      customMessageDisplay.showMessage(msg);
                    }
                  },
                  child: Button(title: "Verify Phone Number")),
              SizedBox(height: 0.03 * height),
            ]),
          ),
        ),
      ),
    );
  }
}
