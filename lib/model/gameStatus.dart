class GameStatus {
  String playerMistakes = "0";
  String opponentMistakes = "0";
  String result;

  GameStatus({this.playerMistakes, this.opponentMistakes});

  factory GameStatus.fromJson(Map<String, dynamic> json) {
    return GameStatus(
      playerMistakes: json['playerMistakes'],
      opponentMistakes: json['opponentMistakes'],
    );
  }
}