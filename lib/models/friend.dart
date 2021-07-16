class Friend {
  String friendId;
  String friendName;
  int relationId;

  Friend({
    this.friendId,
    this.friendName,
    this.relationId
  });

  factory Friend.fromJson(Map<String, dynamic> json){
    return new Friend(
        friendId: json['friendId'],
        friendName: json ['friendName'],
        relationId: json['relationId']
    );
  }
}