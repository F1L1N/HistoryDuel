class Question {
  final String id;
  final String question;
  String variant1;
  String variant2;
  String variant3;
  String variant4;

  Question({this.id, this.question, this.variant1, this.variant2, this.variant3, this.variant4});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      question: json['question'],
      variant1: json['variant1'],
      variant2: json['variant2'],
      variant3: json['variant3'],
      variant4: json['variant4'],
    );

  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["question"] = question;
    map["variant1"] = variant1;
    map["variant2"] = variant2;
    map["variant3"] = variant3;
    map["variant4"] = variant4;
    return map;
  }
}