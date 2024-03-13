class JoinPools {
  final String pool_name;
  final String pool_code;
  final String no_players;

  JoinPools(
      {required this.pool_name,
      required this.pool_code,
      required this.no_players});
  factory JoinPools.fromjson(Map<String, dynamic> json) {
    return JoinPools(
        pool_name: json["pool_name"],
        pool_code: json["pool_code"],
        no_players: json["no_players"].toString());
  }
}