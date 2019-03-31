class RefreshPost {
  final String refresh;

  RefreshPost({this.refresh});

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["refresh"] = refresh;
    return map;
  }
}