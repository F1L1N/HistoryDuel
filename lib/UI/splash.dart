import 'package:flutter/material.dart';
import 'package:history_duel/UI/login.dart';
import 'package:splashscreen/splashscreen.dart';

class LaunchScreen extends StatefulWidget {
  @override
  LaunchScreenState createState() => new LaunchScreenState();
}

class LaunchScreenState extends State<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
            body: new Center(
                child: new Container(
                  child: new SplashScreen(
                      seconds: 2,
                      navigateAfterSeconds: new LoginScreen(),
                      image: Image.asset('assets/image/logo.png'),
                      backgroundColor: Colors.white,
                      styleTextUnderTheLoader: new TextStyle(),
                      photoSize: 150.0
                  ),
                  padding: new EdgeInsets.only(top: 100.0),
                )
            )
        )
    );
  }
}