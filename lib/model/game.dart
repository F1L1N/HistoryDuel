import 'package:history_duel/model/gameStatus.dart';
import 'package:history_duel/model/opponent.dart';

class Game {
  GameStatus gameStatus;
  Player opponent;

  Game(this.gameStatus, this.opponent);

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(new GameStatus(playerMistakes: json['playerMistakes'], opponentMistakes: json['opponentMistakes']),
                new Player(playerId: json['opponentId'], playerLogin: json['opponentLogin']));
  }
}