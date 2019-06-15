import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:history_duel/UI/custom/gameButton.dart';
import 'package:history_duel/model/post/getQuestion.dart';
import 'package:history_duel/model/opponent.dart';
import 'package:history_duel/model/question.dart';
import 'package:http/http.dart' as http;
import 'package:history_duel/utils/gameManager.dart';

class GameScreen extends StatefulWidget {
  //GameScreen({Key key}) : super(key: key);
  String playerId;
  String login;
  Opponent opponent;
  Avataaar playerAvatar;
  Avataaar opponentAvatar;

  GameScreen(String playerId, String login, Opponent opponent) {
    this.playerId = playerId;
    this.login = login;
    this.opponent = opponent;
  }

  @override
  GameScreenState createState() => new GameScreenState(playerId, login, opponent);

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


  String gameUrl = "http://hisduel.000webhostapp.com/game.php";
  String result;
  String playerId;
  String login;
  Opponent opponent;
  Avataaar playerAvatar = new Avataaar.random();
  Avataaar opponentAvatar = new Avataaar.random();
  Question currentQuestion = new Question();
  bool timerStarted = false;
  GameManager gameManager;



  Timer _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timeoutHandler();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void timeoutHandler() {
      _start = 30;
      question = null;
      timerStarted = false;

  }


  GameScreenState(String playerId, String login, Opponent opponent) {
    this.playerId = playerId;
    this.login = login;
    this.opponent = opponent;
    gameManager = new GameManager(playerId);

    startTimer();
  }

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Game",
      home: new Scaffold(
          body: new Container(
            padding: const EdgeInsets.all(30.0),
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new AvataaarImage(
                        avatar: playerAvatar,
                        errorImage: Icon(Icons.error),
                        placeholder: CircularProgressIndicator(),
                        width: 100.0,
                      ),
                      new Text(login),
                    ],
                  ),
                  new Center(
                      child: new FutureBuilder<Question>(
                          future: runQuestionPost(),
                          builder: (context, snapshot) {
                            if((snapshot.connectionState == ConnectionState.done || timerStarted) && question != null) {
                              if(snapshot.hasError){
                                return Text("Error");
                              }
                              timerStarted = true;
                              return new Column(
                                  children: <Widget>[
                                    new Text('${snapshot.data.question}'),
                                    new Container(
                                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                                        child: new Column(
                                          children: <Widget>[
                                            new gameButton(1, snapshot.data.variant1),
                                            new gameButton(2, snapshot.data.variant2),
                                            new gameButton(3, snapshot.data.variant3),
                                            new gameButton(4, snapshot.data.variant4),
                                          ],
                                        )
                                    ),
                                    if (_start != 0) new Text("$_start"),
                                  ]
                              );
                            }
                            else return CircularProgressIndicator();
                          }
                      )

                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      new Text(opponent.opponentLogin),
                      new AvataaarImage(
                        avatar: opponentAvatar,
                        errorImage: Icon(Icons.error),
                        placeholder: CircularProgressIndicator(),
                        width: 100.0,
                      ),

                    ],
                  ),
                ]
            ),
          )

      ),
    );
  }

  var question;
  var questionPostProcessed = false;

  Future<Question> runQuestionPost({Map body}) async {
    if (question == null && !questionPostProcessed) {
      questionPostProcessed = true;
      GetQuestionPost newPost = new GetQuestionPost(
          mode: "1"
      );
      final response = await http.post(gameUrl,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
          },
          body: newPost.toMap()
      );
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
//      question = Question.fromJson(json.decode(response.body));
      question = await gameManager.setCurrentQuestion();
      questionPostProcessed = false;
    }

    return question;
  }



//  void getQuestions() async {
//    GetQuestionPost newPost = new GetQuestionPost(
//        mode: "1"
//    );
//    currentQuestion = await runQuestionPost(body: newPost.toMap());
//    currentQuestion.variant1 = "1";
//  }
}

