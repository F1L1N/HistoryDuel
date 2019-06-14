class GetQuestionPost {
  final String mode;

  GetQuestionPost({this.mode});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["mode"] = mode;
    return map;
  }
}