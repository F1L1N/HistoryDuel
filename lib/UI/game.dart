import 'dart:async';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:history_duel/UI/custom/gameButton.dart';
import 'package:history_duel/model/opponent.dart';
import 'package:history_duel/model/question.dart';
import 'package:history_duel/utils/gameManager.dart';
import 'package:history_duel/model/gameStatus.dart';
import 'package:history_duel/UI/custom/heartBar';
import 'package:history_duel/model/game.dart';
import 'package:history_duel/utils/timer.dart';

class GameScreen extends StatefulWidget {
  //GameScreen({Key key}) : super(key: key);
  String playerId;
  String login;
  Player opponent;
  GameStatus gameStatus;
  Avataaar playerAvatar;
  Avataaar opponentAvatar;

  GameScreen(Player player, Game game) {
    this.playerId = player.playerId;
    this.login = player.playerLogin;
    this.opponent = game.opponent;

  }

  @override
  GameScreenState createState() => new GameScreenState(playerId, gameStatus);
}

class GameScreenState extends State<GameScreen>{
// ignore: must_be_immutable
//class GameScreen extends StatelessWidget {
  String gameUrl = "http://hisduel.000webhostapp.com/game.php";
  String result;
  String endGame;
  Avataaar playerAvatar = new Avataaar.random();
  Avataaar opponentAvatar = new Avataaar.random();
  Question currentQuestion = new Question();
  bool timerStarted = false;
  GameStatus gameStatus;
  GameManager gameManager;


  GameScreenState(String playerId, GameStatus status) {
    //gameStatus = new GameStatus(playerMistakes: "0", opponentMistakes: "0");
    gameStatus = status;
    gameStatus.result = "NEXT";
    gameManager = new GameManager(playerId);
  }

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
      if (gameStatus.result != "NEXT") {
        return MaterialApp(
            title: "Game",
            home: new Scaffold(
                body: new Container(
                    padding: const EdgeInsets.all(30.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: new Center(
                        child:
                          new Text(gameStatus.result)
                    )
                )
            )
        );
      } else {
        return MaterialApp(
          title: "Game",
          home: new Scaffold(
              body: new Container(
                padding: const EdgeInsets.all(30.0),
                child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new AvataaarImage(
                            avatar: playerAvatar,
                            errorImage: Icon(Icons.error),
                            placeholder: CircularProgressIndicator(),
                            width: 75.0,
                          ),
                          new Text(widget.login),
                          new HeartBar(int.parse(gameStatus.playerMistakes)),
                        ],
                      ),
                      new Center(
                          child: new FutureBuilder<Question>(
                              future: runQuestionPost(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Text("Error");
                                  }
                                  return new Column(
                                      children: <Widget>[
                                        new Text('${snapshot.data.question}'),
                                        new Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 30, 0, 20),
                                            child: new Column(

                                              children: <Widget>[
                                                new GameButton(1,
                                                    snapshot.data.variant1, () {
                                                      sendAnswer("1");
                                                    }),
                                                new GameButton(2,
                                                    snapshot.data.variant2, () {
                                                      sendAnswer("2");
                                                    }),
                                                new GameButton(3,
                                                    snapshot.data.variant3, () {
                                                      sendAnswer("3");
                                                    }),
                                                new GameButton(4,
                                                    snapshot.data.variant4, () {
                                                      sendAnswer("4");
                                                    }),
                                              ],
                                            )
                                        ),
                                        new GameTimer(() {
                                          if (!answerSend) {
                                            sendAnswer("-1");
                                          }
                                        }
                                        ),
                                      ]
                                  );
                                }
                                else
                                  return CircularProgressIndicator();
                              }
                          )

                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new HeartBar(int.parse(gameStatus.opponentMistakes)),
                          new Text(widget.opponent.playerLogin),
                          new AvataaarImage(
                            avatar: opponentAvatar,
                            errorImage: Icon(Icons.error),
                            placeholder: CircularProgressIndicator(),
                            width: 75.0,
                          ),

                        ],
                      ),
                    ]
                ),
              )

          ),
        );
      }
  }


  Future<Question> runQuestionPost() async {
    return await gameManager.setCurrentQuestion();
  }

  var answerSend = false;

  Future sendAnswer(String answer) async {
    if (answerSend) {
      return;
    }
    answerSend = true;
    var gameStatus = await gameManager.sendAnswer(answer);
    setState(() {
      answerSend = false;
      this.gameStatus = gameStatus;
    });

  }

}

