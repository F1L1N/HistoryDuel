import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  String email;
  String password;
  final sizeTextBlack = const TextStyle(fontSize: 20.0, color: Colors.black);

  MainScreen(String email, String password) {
    email = email;
    password = password;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Second Screen"),
        ),
        body: new Center(
          child: new Text(
            "Email: $email, password: $password",
            style: sizeTextBlack,
          ),
        ));
  }
}