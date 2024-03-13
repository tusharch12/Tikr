class create_fund {
  final String msg;
  final bool auth;
  final Map<String, dynamic> data;

  create_fund({required this.data, required this.auth, required this.msg});

  factory create_fund.fromjson(Map<String, dynamic> json) {
    return create_fund(
        auth: json["auth"],
        msg: json["msg"],
        data: {"new_entity": json["data"]["new_entity"]});
  }
}