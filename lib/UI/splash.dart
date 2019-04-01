import 'package:flutter/material.dart';
import 'package:history_duel/UI/auth.dart';
import 'package:history_duel/UI/login_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(LaunchScreen());

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
                      seconds: 1,
                      navigateAfterSeconds: new LoginPage(),
                      image: Image.asset('assets/image/logo.jpg'),
                      backgroundColor: Colors.white,
                      styleTextUnderTheLoader: new TextStyle(),
                      photoSize: 200.0
                  ),
                  padding: new EdgeInsets.only(top: 100.0),
                )
            )
        )
    );
  }
}