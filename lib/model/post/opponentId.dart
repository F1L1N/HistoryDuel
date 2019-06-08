class OpponentIdPost {
  final String playerId;
  String opponentId;
  String mode;

  OpponentIdPost(this.playerId, this.mode);

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = playerId;
    map["mode"] = mode;
    return map;
  }

  factory OpponentIdPost.fromJson(Map<String, dynamic> json) {
    return json['opponentId'];
  }
}