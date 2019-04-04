import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:history_duel/UI/game.dart';
import 'package:history_duel/model/post/opponentId.dart';
import 'package:history_duel/model/profile.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  String id;
  String login;
  String regEmail;
  String email;
  String regDate;
  String url = "http://hisduel.000webhostapp.com/matchmaker.php";
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

  Future<int> getOpponentIdPost({Map body}) async {
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
    return json.decode(response.body);
  }

  Future matchmaking() async {
    int id = int.parse(this.id);
    OpponentIdPost newPost = new OpponentIdPost(id);
    int opponentId = await getOpponentIdPost(body: newPost.toMap());
    navigateGame(id, opponentId);
  }

  void navigateGame(int playerId, int opponentId){
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new GameScreen(playerId, opponentId)));
  }
}