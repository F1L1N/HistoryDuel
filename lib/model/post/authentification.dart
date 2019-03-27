class AuthenticationPost {
  final String login;
  final String password;

  AuthenticationPost({this.login, this.password});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["login"] = login;
    map["password"] = password;
    return map;
  }
}