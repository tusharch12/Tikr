class homePageStockList_modal {
  final int index;
  final String yahoo_tkr_name;
  final String display_name;
  final String currency;
  final String rank;
  final String last_price;
  final String active_player;

  homePageStockList_modal(
      {required this.index,
      required this.yahoo_tkr_name,
      required this.display_name,
      required this.currency,
      required this.rank,
      required this.last_price,
      required this.active_player,

      });

  factory homePageStockList_modal.fromjson(Map<String, dynamic> json) {
    return homePageStockList_modal(
      index: json["index"],
      yahoo_tkr_name: json["yahoo_tkr_name"],
      display_name: json["display_name"],
      currency: json["currency"],
      rank: json["rank"],
      last_price: json["last_price"].toString(),
        active_player: json["active_players"].toString(),
    );
  }
}