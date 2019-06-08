import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:history_duel/UI/custom/gameButton.dart';

class GameScreen extends StatefulWidget {
  //GameScreen({Key key}) : super(key: key);
  String playerId;
  String opponentId;
  Avataaar playerAvatar;
  Avataaar opponentAvatar;

  GameScreen(String playerId, String opponentId) {
    this.playerId = playerId;
    this.opponentId = opponentId;
  }

  @override
  GameScreenState createState() => new GameScreenState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:"Game",
        home: new Scaffold(
          body: new Container(
            padding: const EdgeInsets.all(5.0),
            child: new Row(
              children: <Widget>[
                  AvataaarImage(
                    avatar: playerAvatar,
                    errorImage: Icon(Icons.error),
                    placeholder: CircularProgressIndicator(),
                    width: 128.0,
                  ),
                  new Text('$playerId'),
              ],
            ),
          )
        )
    );
  }
}

class GameScreenState extends State<GameScreen>{
// ignore: must_be_immutable
//class GameScreen extends StatelessWidget {

  String question = "";
  String variant1 = "";
  String variant2 = "";
  String variant3 = "";
  String variant4 = "";
  String result;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Game",
      home: new Scaffold(
        body: new Container(
          padding: const EdgeInsets.all(100.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text('$question'),
                new gameButton(1, variant1),
                new gameButton(2, variant2),
                new gameButton(3, variant3),
                new gameButton(4, variant4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}