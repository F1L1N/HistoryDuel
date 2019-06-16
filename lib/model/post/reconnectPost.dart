class ReconnectPost{
  final String mode;
  final String playerId;

  ReconnectPost(this.mode, this.playerId);

  Map toMap(){
    var map = new Map<String, dynamic>();
    map["mode"] = mode;
    map["playerId"] = playerId;
    return map;
  }
}