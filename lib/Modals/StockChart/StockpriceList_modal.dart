class stockPriceList {
  final String Datetime;
  final String Open;
  final String High;
  final String Low;
  final String Close;
  final String Volume;
  // final bool auth;
  final int no_users;

stockPriceList(
      {required this.Datetime,
      required this.Open,
      required this.High,
      required this.Low,
      required this.Close,
      required this.Volume,
      // required this.auth,
      required this.no_users});

  factory stockPriceList.fromjson(Map<String, dynamic> json) {
    return stockPriceList(
        Datetime: json["Datetime"].toString(),
        Open: json["Open"].toString(),
        High: json["High"].toString(),
        Low: json["Low"].toString(),
        Close: json["Close"].toString(),
        Volume: json["Volume"].toString(),
        // auth: json["auth"],
        no_users: json["no_users"]);
  }
}

class ChartData {
  DateTime dateTime;
  final num Open;
  final num High;
  final num Low;
  final num Close;

  ChartData({
    required this.dateTime,
    required this.Open,
    required this.High,
    required this.Low,
    required this.Close,
  });

  factory ChartData.fromjson(Map<String, dynamic> json) {
    return ChartData(
        Open: json["Open"],
        High: json["High"],
        Low: json["Low"],
        Close: json["Close"],
        dateTime: DateTime.fromMillisecondsSinceEpoch(json["Datetime"],
            isUtc: false));
  }
}