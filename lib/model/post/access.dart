class AccessPost {
  final String access;

  AccessPost(this.access);

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["access"] = access;
    return map;
  }
}