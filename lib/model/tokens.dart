class Tokens {
  final String accessToken;
  final String refreshToken;

  Tokens({this.accessToken, this.refreshToken});

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}