class Profile {
  final String id;
  final String login;
  final String registrationEmail;
  final String email;
  final String registrationDate;

  Profile({this.id, this.login, this.registrationEmail, this.registrationDate, this.email});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      login: json['login'],
      registrationEmail: json['regEmail'],
      email: json['email'],
      registrationDate: json['regDate'],
    );
    
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["login"] = login;
    map["regEmail"] = registrationEmail;
    map["email"] = email;
    map["regDate"] = registrationDate;
    return map;
  }
}