class GameStatus {
  String playerMistakes;
  String opponentMistakes;
  String result = "NEXT";

  GameStatus({this.playerMistakes, this.opponentMistakes});

  factory GameStatus.fromJson(Map<String, dynamic> json) {
    return GameStatus(
      playerMistakes: json['playerMistakes'],
      opponentMistakes: json['opponentMistakes'],
    );
  }
}