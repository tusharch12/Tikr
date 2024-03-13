class publicPool {
  final String pool_name;
  final String pool_code;
  final String no_players;
  final String total_winnings;

  publicPool(
      {required this.total_winnings,
      required this.pool_name,
      required this.pool_code,
      required this.no_players});
  factory publicPool.fromjson(Map<String, dynamic> json) {
    return publicPool(
        total_winnings: json["total_winnings"].toString(),
        pool_name: json["pool_name"],
        pool_code: json["pool_code"],
        no_players: json["no_players"].toString());
  }
}