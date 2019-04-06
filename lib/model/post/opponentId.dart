class OpponentIdPost {
  final String playerId;
  String opponentId;

  OpponentIdPost(this.playerId);

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["playerId"] = playerId;
    return map;
  }

  factory OpponentIdPost.fromJson(Map<String, dynamic> json) {
    return json['opponentId'];
  }
}