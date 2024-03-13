class userProfileRes {
  String msg;
  bool auth;
  Map<String, String> data;

  userProfileRes({required this.msg, required this.auth, required this.data});

  factory userProfileRes.fromJson(Map<String, dynamic> json) {
    return userProfileRes(msg: json["msg"], auth: json["auth"], data: {
      "userid": json["data"]["userid"] as String,
    });
  }
}
