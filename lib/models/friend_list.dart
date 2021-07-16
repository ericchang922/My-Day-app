import 'friend.dart';

class FriendList {
  List<Friend> friends = new List();

  FriendList({
    this.friends
  });
  
  factory FriendList.fromJson(List<dynamic> parsedJson) {
    List<Friend> friends = new List<Friend>();
    friends = parsedJson.map((i) => Friend.fromJson(i)).toList();
    return new FriendList(
      friends: friends,
    );
  }
}