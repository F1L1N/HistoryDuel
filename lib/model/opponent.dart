class Opponent {
  final String opponentId;
  final String opponentLogin;

  Opponent({this.opponentId, this.opponentLogin});

  factory Opponent.fromJson(Map<String, dynamic> json) {
    return Opponent(
      opponentId: json['opponentId'],
      opponentLogin: json['opponentLogin'],
    );
  }
}