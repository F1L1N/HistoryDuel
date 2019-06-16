import 'dart:convert';
import 'dart:io';

import 'package:history_duel/UI/splash.dart';
import 'package:flutter/material.dart';
import 'package:history_duel/UI/game.dart';
import 'package:history_duel/model/post/opponentId.dart';
import 'package:history_duel/model/post/reconnectPost.dart';
import 'package:history_duel/model/profile.dart';
import 'package:history_duel/model/opponent.dart';
import 'package:history_duel/model/game.dart';
import 'package:history_duel/model/gameStatus.dart';
import 'package:http/http.dart' as http;

void main() => runApp(LaunchScreen());
// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  String id;
  String login;
  String regEmail;
  String email;
  String regDate;
  static String url = "http://hisduel.000webhostapp.com/matchmaker.php";

// Set default configs
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);
  BuildContext context;

  MainScreen(Profile profile) {
    this.id = profile.id;
    this.login = profile.login;
    this.regEmail = profile.registrationEmail;
    this.email = profile.email;
    this.regDate = profile.registrationDate;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    reconnect();
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Main Screen"),
        ),
        body: new Center(
          child: new Text(
            "ID: $id, login: $login, date: $regDate, regEmail: $regEmail, email: $email",
            style: sizeTextBlack,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: matchmaking,
          tooltip: 'Increment',
          child: Icon(Icons.find_replace),
      ),
    );
  }

  Future<Player> getOpponentIdPost({Map body}) async {
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
        },
        body: body
    );
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    Player result = Player.fromJson(json.decode(response.body));
    return result;
  }

  Future<Game> getGamePost(Map body) async {
    final response = await http.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
        },
        body: body
    );
    final int statusCode = response.statusCode;
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    }
    Game result = Game.fromJson(json.decode(response.body));
    return result;
  }

  Future matchmaking() async {
    OpponentIdPost newPost = new OpponentIdPost(this.id, 'connect');
    Player opponent = await getOpponentIdPost(body:newPost.toMap());
    navigateGame(new Player(playerId: this.id, playerLogin: this.login),
        new Game(new GameStatus(playerMistakes: "0", opponentMistakes: "0"), opponent));
  }

  Future reconnect() async {
    ReconnectPost newPost = new ReconnectPost(this.id, 'reconnect');
    Game game = await getGamePost(newPost.toMap());
    if (game.opponent.playerId != "none")
    {
      navigateGame(new Player(playerId: this.id, playerLogin: this.login), game);
    }
  }

  void navigateGame(Player player, Game gameStatus){
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new GameScreen(player, gameStatus)));
  }

}