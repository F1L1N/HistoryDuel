import 'package:flutter/material.dart';
import 'package:history_duel/model/profile.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  Profile profile;
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);

  MainScreen() {
    //this.email = email;
    //this.login = login;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Second Screen"),
        ),
        body: new Center(
          child: new Text(
            "Email: $profile",
            style: sizeTextBlack,
          ),
        ));
  }
}