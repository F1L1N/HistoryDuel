import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:avataaar_image/avataaar_image.dart';
import 'package:flutter/material.dart';
import 'package:history_duel/UI/custom/gameButton.dart';
import 'package:history_duel/model/post/getQuestion.dart';
import 'package:history_duel/model/question.dart';
import 'package:http/http.dart' as http;

class GameScreen extends StatefulWidget {
  //GameScreen({Key key}) : super(key: key);
  String playerId;
  String login;
  String opponentId;
  Avataaar playerAvatar;
  Avataaar opponentAvatar;

  GameScreen(String playerId, String login, String opponentId) {
    this.playerId = playerId;
    this.login = login;
    this.opponentId = opponentId;
  }

  @override
  GameScreenState createState() => new GameScreenState(playerId, login, opponentId);

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
  String opponentId;
  Avataaar playerAvatar = new Avataaar.random();
  Question currentQuestion = new Question();

  GameScreenState(String playerId, String login, String opponentId) {
    this.playerId = playerId;
    this.login = login;
    this.opponentId = opponentId;
  }

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Game",
      home: new Scaffold(
        body: new Container(
          padding: const EdgeInsets.all(30.0),
          child: new Center(
            child: new FutureBuilder<Question>(
                future: runQuestionPost(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    if(snapshot.hasError){
                      return Text("Error");
                    }
                    return new Column(
                        children: <Widget>[
                          new Text('${snapshot.data.question}'),
                          new Container(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: new Column(
                              children: <Widget>[
                                new gameButton(1, snapshot.data.variant1),
                                new gameButton(2, snapshot.data.variant2),
                                new gameButton(3, snapshot.data.variant3),
                                new gameButton(4, snapshot.data.variant4),
                              ],
                            )
                          ),

                          new AvataaarImage(
                            avatar: playerAvatar,
                            errorImage: Icon(Icons.error),
                            placeholder: CircularProgressIndicator(),
                            width: 100.0,
                          ),
                        ]);

                  }
                  else
                    return CircularProgressIndicator();
                }
            )

          ),
        ),
      ),
    );
  }

 /* @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body : FutureBuilder<Question>(
            future: runQuestionPost(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {

                if(snapshot.hasError){
                  return Text("Error");
                }

                return Text('Title from Post JSON : ${snapshot.data.variant1}');

              }
              else
                return CircularProgressIndicator();
            }
        )
    );
  }
*/
  Future<Question> runQuestionPost({Map body}) async {
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
    return Question.fromJson(json.decode(response.body));
  }

  void getQuestions() async {
    GetQuestionPost newPost = new GetQuestionPost(
        mode: "1"
    );
    currentQuestion = await runQuestionPost(body: newPost.toMap());
    currentQuestion.variant1 = "1";
  }
}

