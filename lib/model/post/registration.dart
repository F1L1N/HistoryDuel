class RegistrationPost {
  final String login;
  final String email;
  final String password;

  RegistrationPost({this.login, this.email, this.password});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["login"] = login;
    map["email"] = email;
    map["password"] = password;
    return map;
  }
}