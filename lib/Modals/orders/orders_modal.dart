class order {
  final String StockName;
  final double amount;
  final double winning_amount;
  final String play_time;
  final String Player_type;
  final String Play_direction;
  final String counter_investment;
  final String pool_name;
  final String balance_updated;
  final String phone_no;
  final String username;
  final String game_id;
  final String entity_name;
  final String interval;
  final String pool_code;
  final String counter_direction;
  final int ticket;
  final double final_double_balance;
  final double commission;
  final String datetime;
  final String msg;
  final String pool_type;

  order(
      {required this.StockName,
      required this.amount,
      required this.play_time,
      required this.Player_type,
      required this.Play_direction,
      required this.counter_investment,
      required this.winning_amount,
      required this.pool_name,
      required this.balance_updated,
      required this.commission,
      required this.game_id,
      required this.entity_name,
      required this.interval,
      required this.pool_code,
      required this.msg,
      required this.ticket,
      required this.final_double_balance,
      required this.datetime,
      required this.counter_direction,
      required this.username,
      required this.phone_no,
      required this.pool_type});
  factory order.fromjson(Map<String, dynamic> json) {
    return order(
        StockName: json["entity_name"],
        amount: json["amount"],
        play_time: json["play_time"],
        Player_type: json["player_type"],
        Play_direction: json["play_direction"],
        counter_investment: json["counter_investment"].toString(),
        winning_amount: json["winning_amount"],
        pool_name: json["pool_name"],
        balance_updated: json["balance_updated"],
        game_id: json["game_id"],
        entity_name: json["entity_name"],
        interval: json["interval"],
        pool_code: json["pool_code"],
        counter_direction: json["counter_direction"],
        ticket: json["ticket"],
        final_double_balance: json["balance"],
        commission: json["commission"],
        datetime: json["datetime"],
        msg: json["msg"],
        username: json["username"],
        phone_no: json["phone_no"],
        pool_type: json["pool_type"]);
  }
}
