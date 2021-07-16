import 'friend_list.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
class FriendService {
  
  Future<String> _loadFriendsAsset() async {
    return await rootBundle.loadString('assets/json/friends.json');
  }

  Future<FriendList> loadFriends() async {
    String jsonString = await _loadFriendsAsset();
    final jsonResponse = json.decode(jsonString);
    FriendList friends = new FriendList.fromJson(jsonResponse);
    return friends;
  }
}