class ReconnectPost{
  final String mode;
  final String id;

  ReconnectPost(this.mode, this.id);

  Map toMap(){
    var map = new Map<String, dynamic>();
    map["mode"] = mode;
    map["id"] = id;
    return map;
  }
}