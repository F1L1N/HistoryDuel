import 'dart:convert';
import 'dart:io';

import 'package:history_duel/UI/splash.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:flutter/material.dart';
import 'package:history_duel/UI/game.dart';
import 'package:history_duel/model/post/opponentId.dart';
import 'package:history_duel/model/profile.dart';
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

  Future<String> getOpponentIdPost({Map body}) async {
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
    OpponentIdPost newPost = new OpponentIdPost(this.id);
    String opponentId = await getOpponentIdPost(body:newPost.toMap());
    navigateGame(id, opponentId);
  }

  void navigateGame(String playerId, String opponentId){
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new GameScreen(playerId, opponentId)));
  }
}