import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupInvitePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('邀請好友', style: TextStyle(fontSize: screenSize.width * 0.052)),
        leading: Container(
          margin: EdgeInsets.only(left: screenSize.height * 0.02),
          child: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Column(children: [Expanded(child: GroupInviteWidget())]),
    );
  }
}

class GroupInviteWidget extends StatefulWidget {
  @override
  State<GroupInviteWidget> createState() => new _GroupInviteState();
}

class _GroupInviteState extends State<GroupInviteWidget> {
  final _friendNameController = TextEditingController();

  String _searchText = "";
  String uid = 'lili123';

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];
  FriendListModel _friendListModel = null;
  BestFriendListModel _bestFriendListModel = null;

  @override
  void initState() {
    super.initState();

    _getFriendRequest();
    _getBestFriendRequest();
  }

  void _getBestFriendRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/best_friends.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/friend/best_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var bestFriendListModel = BestFriendListModel.fromJson(jsonBody);

    setState(() {
      _bestFriendListModel = bestFriendListModel;

      for (int i = 0; i < bestFriendListModel.friend.length; i++) {
        _bestFriendCheck[bestFriendListModel.friend[i].friendId] = false;
      }
    });
  }

  void _getFriendRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/friend_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/friend/friend_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var friendListModel = FriendListModel.fromJson(jsonBody);

    setState(() {
      _friendListModel = friendListModel;

      for (int i = 0; i < friendListModel.friend.length; i++) {
        _friendCheck[friendListModel.friend[i].friendId] = false;
      }
    });
  }

  _GroupInviteState() {
    _friendNameController.addListener(() {
      if (_friendNameController.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _friendNameController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _buildSearch(context),
          _buildCheckAll(context),
          Expanded(child: _buildList(context)),
          _buildCheckButtom(context)
        ],
      ),
    );
  }

  Widget _buildSearch(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          right: screenSize.height * 0.02, left: screenSize.height * 0.01),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: screenSize.height * 0.01),
            child: IconButton(
              icon: Image.asset(
                'assets/images/search.png',
                width: screenSize.width * 0.05,
              ),
              onPressed: () {},
            ),
          ),
          Flexible(
            child: Container(
              height: screenSize.height * 0.04683,
              child: TextField(
                style: TextStyle(fontSize: screenSize.width * 0.041),
                decoration: InputDecoration(
                    hintText: '輸入好友名稱搜尋',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.01,
                        vertical: screenSize.height * 0.01),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenSize.height * 0.01)),
                      borderSide: BorderSide(
                        color: Color(0xff070707),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenSize.height * 0.01)),
                      borderSide: BorderSide(color: Color(0xff7AAAD8)),
                    )),
                controller: _friendNameController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckAll(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: screenSize.width * 0.03),
      alignment: Alignment.centerRight,
      child: FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        height: 6,
        minWidth: 5,
        child: Text('全選', style: TextStyle(fontSize: screenSize.width * 0.035)),
        onPressed: () {
          setState(() {
            if (_friendNameController.text.isEmpty) {
              for (int i = 0; i < _friendListModel.friend.length; i++) {
                _friendCheck[_friendListModel.friend[i].friendId] = true;
              }
              for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
                _bestFriendCheck[_bestFriendListModel.friend[i].friendId] = true;
              }
            } else {
              if (_filteredFriend.length != 0) {
                for (int i = 0; i < _filteredFriend.length; i++) {
                  _friendCheck[_filteredFriend[i].friendId] = true;
                }
              }
              if (_filteredBestFriend.length != 0) {
                for (int i = 0; i < _filteredBestFriend.length; i++) {
                  _bestFriendCheck[_filteredBestFriend[i].friendId] = true;
                }
              }
            }
          });
        },
      ),
    );
  }

  Widget _buildList(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    if (_searchText.isEmpty) {
      if (_friendListModel != null && _bestFriendListModel != null) {
        return ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  bottom: screenSize.width * 0.02,
                  top: screenSize.width * 0.02),
              child: Text('摯友',
                  style: TextStyle(fontSize: screenSize.width * 0.041, color: Color(0xff7AAAD8))),
            ),
            _buildBestFriendList(context),
            Container(
              margin: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  bottom: screenSize.width * 0.02,
                  top: screenSize.width * 0.02),
              child: Text('好友',
                  style: TextStyle(fontSize: screenSize.width * 0.041, color: Color(0xff7AAAD8))),
            ),
            _buildFriendList(context)
          ],
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    } else {
      _filteredBestFriend = [];
      _filteredFriend = [];

      for (int i = 0; i < _friendListModel.friend.length; i++) {
        if (_friendListModel.friend[i].friendName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredFriend.add(_friendListModel.friend[i]);
        }
      }
      for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
        if (_bestFriendListModel.friend[i].friendName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredBestFriend.add(_bestFriendListModel.friend[i]);
        }
      }

      return ListView(
        children: [
          if (_filteredBestFriend.length > 0)
            _buildSearchBestFriendList(context),
          if (_filteredFriend.length > 0) _buildSearchFriendList(context)
        ],
      );
    }
  }

  Image getImage(String imageString) {
  var screenSize = MediaQuery.of(context).size;
    bool isGetImage;
    Image friendImage = Image.asset(
      'assets/images/friend_choose.png',
      width: screenSize.height * 0.04683,
    );
    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(base64.decode(imageString),
        width: screenSize.height * 0.04683, height: screenSize.height * 0.04683, fit: BoxFit.fill);
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('error');
    }));

    if (isGetImage == true) {
      return image;
    } else {
      return friendImage;
    }
  }

  Widget _buildBestFriendList(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _bestFriendListModel.friend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _bestFriendListModel.friend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
          ),
          trailing: CustomerCheckBox(
            value: _bestFriendCheck[friends.friendId],
            onTap: (value) {
              setState(() {
                _bestFriendCheck[friends.friendId] = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _bestFriendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildFriendList(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _friendListModel.friend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _friendListModel.friend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
          ),
          trailing: CustomerCheckBox(
            value: _friendCheck[friends.friendId],
            onTap: (value) {
              setState(() {
                _friendCheck[friends.friendId] = value;
              });
            },
          ),
          onTap: () {
            setState(() {
              _friendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchBestFriendList(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredBestFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredBestFriend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
          ),
          trailing: CustomerCheckBox(
            value: _bestFriendCheck[friends.friendId],
            onTap: (value) {
              setState(() {
                _bestFriendCheck[friends.friendId] = value;
                print(_bestFriendCheck);
              });
            },
          ),
          onTap: () {
            setState(() {
              _bestFriendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchFriendList(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredFriend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
          ),
          trailing: CustomerCheckBox(
            value: _friendCheck[friends.friendId],
            onTap: (value) {
              setState(() {
                _friendCheck[friends.friendId] = value;
                print(_friendCheck);
              });
            },
          ),
          onTap: () {
            setState(() {
              _friendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildCheckButtom(BuildContext context) {
  var screenSize = MediaQuery.of(context).size;
    return Container(
        alignment: Alignment.bottomCenter,
        child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: screenSize.height * 0.07,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Image.asset(
                'assets/images/cancel.png',
                width: screenSize.width * 0.05,
              ),
              color: Theme.of(context).primaryColorLight,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: screenSize.height * 0.07,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Image.asset(
                'assets/images/confirm.png',
                width: screenSize.width * 0.05,
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ]));
  }
}
