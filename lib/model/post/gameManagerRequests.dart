class GameManagerPost {
  String mode;
  String id;
  String gameId;
  String questionId;
  String answer;

  GameManagerPost({this.mode, this.id, this.gameId, this.questionId, this.answer});

  Map toMap() {
    var map = new Map<String, dynamic>();
    if (mode != null) { map["mode"] = mode; }
    if (id != null) { map["id"] = id; }
    if (gameId != null) { map["gameId"] = gameId; }
    if (questionId != null) { map["questionId"] = questionId; }
    if (answer != null) { map["answer"] = answer; }
    return map;
  }
}