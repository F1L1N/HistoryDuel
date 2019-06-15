import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:history_duel/model/post/gameManagerRequests.dart';
import 'package:history_duel/model/question.dart';
import 'package:http/http.dart' as http;

class GameManager {
    String id;
    String gameId;
    String questionId;
    String answer;
    String url = "http://hisduel.000webhostapp.com/game.php";

    GameManager(String id) {
        this.id = id;
    }

    Future getQuestionIdPost() async {

        GameManagerPost newPost = new GameManagerPost(
            mode: "0",
            id: id,
        );
        final response = await http.post(url,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
            },
            body: newPost.toMap()
        );
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        var gameId = json.decode(response.body);
        this.gameId = gameId['gameId'];


    }

    Future<Question> setCurrentQuestion() async {
        while (this.gameId == null) {
            await getQuestionIdPost();
        }

        GameManagerPost newPost = new GameManagerPost(
            mode: "6",
            id: id,
            gameId: gameId
        );
        final response = await http.post(url,
            headers: {
                HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
            },
            body: newPost.toMap()
        );
        final int statusCode = response.statusCode;
        if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
        }

        return await getCurrentQuestion();

    }

    Future<Question> getCurrentQuestion() async {

        GameManagerPost newPost = new GameManagerPost(
            mode: "8",
            gameId: gameId
        );
        final response = await http.post(url,
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

}