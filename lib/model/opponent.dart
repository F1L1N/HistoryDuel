class Player {
  final String playerId;
  final String playerLogin;

  Player({this.playerId, this.playerLogin});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerId: json['opponentId'],
      playerLogin: json['opponentLogin'],
    );
  }
}