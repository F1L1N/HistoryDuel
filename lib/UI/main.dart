import 'package:flutter/material.dart';
import 'package:history_duel/model/profile.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  String id;
  String login;
  String regEmail;
  String email;
  String regDate;
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);

  MainScreen(Profile profile) {
    this.id = profile.id;
    this.login = profile.login;
    this.regEmail = profile.registrationEmail;
    this.email = profile.email;
    this.regDate = profile.registrationDate;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Main Screen"),
        ),
        body: new Center(
          child: new Text(
            "ID: $id, login: $login, date: $regDate, regEmail: $regEmail, email: $email",
            style: sizeTextBlack,
          ),
        ));
  }
}