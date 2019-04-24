class OpponentIdPost {
  final String playerId;
  String opponentId;

  OpponentIdPost(this.playerId);

  Map toMap() {
    var map = new Map<String, String>();
    map["id"] = playerId;
    return map;
  }

  factory OpponentIdPost.fromJson(Map<String, dynamic> json) {
    return json['opponentId'];
  }
}