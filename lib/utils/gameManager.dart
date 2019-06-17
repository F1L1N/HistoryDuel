import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:history_duel/model/post/gameManagerRequests.dart';
import 'package:history_duel/model/question.dart';
import 'package:history_duel/model/gameStatus.dart';
import 'package:http/http.dart' as http;

class GameManager {
    String id;
    String gameId;
    String questionId;
    String url = "http://hisduel.000webhostapp.com/game.php";

    GameManager(String id) {
        this.id = id;
    }

    Future getGameIdPost() async {

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
            await getGameIdPost();
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

        while (this.gameId == null) {
            await getGameIdPost();
        }

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
        var question = Question.fromJson(json.decode(response.body));
        questionId = question.id;
        return question;

    }

    Future<GameStatus> sendAnswer(String answer) async {

        GameManagerPost newPost = new GameManagerPost(
            mode: "2",
            id: id,
            questionId: questionId,
            gameId: gameId,
            answer: answer,
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
        var result = await checkResult();
        var gameStatus = GameStatus.fromJson(json.decode(response.body));
        gameStatus.result = result;
        return gameStatus;
    }

    Future<String> checkResult() async {

        GameManagerPost newPost = new GameManagerPost(
            mode: "4",
            id: id,
            gameId: gameId,
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
        var result = json.decode(response.body);
        return result['result'];
    }

}