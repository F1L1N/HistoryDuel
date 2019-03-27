class Profile {
  final String login;
  final String registrationEmail;
  final String email;
  final String registrationDate;

  Profile({this.login, this.registrationEmail, this.registrationDate, this.email});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      login: json['login'],
      registrationEmail: json['registrationEmail'],
      email: json['email'],
      registrationDate: json['registrationDate'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["login"] = login;
    map["registrationEmail"] = registrationEmail;
    map["email"] = email;
    map["registrationDate"] = registrationDate;
    return map;
  }
}