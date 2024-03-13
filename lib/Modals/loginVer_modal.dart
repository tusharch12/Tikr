class login_ver {
  final Map<String, dynamic> data;
  final bool auth;
  final String msg;

  login_ver({required this.data, required this.auth, required this.msg});

  factory login_ver.fromjson(Map<String, dynamic> json) {
    return login_ver(data: {
      "user": {
        "otp_verified": json["data"]["user"]["otp_verified"],
        "userph": json["data"]["user"]["userph"],
        "token": json["data"]["user"]["token"],
      }
    }, auth: json["auth"], msg: json["msg"]);
  }
}