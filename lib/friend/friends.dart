import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/home/home_Update.dart';
import 'package:My_Day_app/friend/bestfriend.dart';
import 'package:My_Day_app/friend/friend_home.dart';
import 'package:My_Day_app/friend/friends_add.dart';
import 'package:My_Day_app/friend/friends_invitation.dart';
import 'package:My_Day_app/public/friend_request/delete.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/public/sizing.dart';

class FriendPage extends StatefulWidget {
  @override
  _friendWidget createState() => new _friendWidget();
}

class _friendWidget extends State<FriendPage> {
  FriendListModel _friendListModel;
  BestFriendListModel _bestFriendListModel;

  final _friendNameController = TextEditingController();

  String _searchText = "";
  String uid = prefs.getString('uid');

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];

  bool viewVisible = true;

  @override
  void initState() {
    super.initState();
    _friendListRequest();
    _bestFriendListRequest();
    _friendNameControlloer();
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  void _friendNameControlloer() {
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

  _bestFriendListRequest() async {
    BestFriendListModel _request =
        await BestFriendList(context: context, uid: uid).getData();

    setState(() {
      _bestFriendListModel = _request;

      for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
        _bestFriendCheck[_bestFriendListModel.friend[i].friendId] = false;
      }
    });
  }

  _friendListRequest() async {
    FriendListModel _request =
        await FriendList(context: context, uid: uid).getData();

    setState(() {
      _friendListModel = _request;

      for (int i = 0; i < _friendListModel.friend.length; i++) {
        _friendCheck[_friendListModel.friend[i].friendId] = false;
      }
    });
  }

  Image getImage(String imageString) {
    Sizing _sizing = Sizing(context);
    double _imgSize = _sizing.height(4.5);
    bool isGetImage;

    Image friendImage = Image.asset(
      'assets/images/friend_choose.png',
      width: _imgSize,
    );
    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(base64.decode(imageString),
        width: _imgSize, height: _imgSize, fit: BoxFit.fill);
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('friends -- getImage error');
    }));

    if (isGetImage == null) {
      return image;
    } else {
      return friendImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _titleSize = _sizing.height(2.5);
    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    Widget friendListWidget;
    _submitDelete(String friendId) async {
      var submitWidget;

      _submitWidgetfunc() async {
        return DeleteFriend(uid: uid, friendId: friendId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    if (_friendListModel != null && _bestFriendListModel != null) {
      Widget friendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _friendListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _friendListModel.friend[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child: getImage(friends.photo),
            ),
            title: TextButton(
                style: TextButton.styleFrom(primary: Colors.black),
                child: Text(
                  friends.friendName,
                  style: TextStyle(fontSize: _pSize),
                ),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeUpdate(child: FriendHome(friends.friendId))));
                }),
            trailing: TextButton(
                style: TextButton.styleFrom(primary: Color(0xffF86D67)),
                child: Text(
                  '移除',
                  style: TextStyle(fontSize: _pSize),
                ),
                onPressed: () async {
                  if (await _submitDelete(friends.friendId) != true) {
                    _friendListRequest();
                  }
                }),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      if (_searchText.isEmpty) {
        if (_bestFriendListModel.friend.length != 0 &&
            _friendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [friendList],
          );
        } else if (_bestFriendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [],
          );
        } else if (_friendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [friendList],
          );
        } else {
          friendListWidget = Center(child: Text('目前沒有任何好友!'));
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

        if (_filteredBestFriend.length > 0 && _filteredFriend.length > 0) {
          friendListWidget = ListView(
            children: [Divider(), _buildSearchFriendList(context)],
          );
        } else {
          friendListWidget = ListView(
            children: [
              if (_filteredFriend.length > 0) _buildSearchFriendList(context)
            ],
          );
        }
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('好友', style: TextStyle(fontSize: _titleSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await friendsAddDialog(context);
              },
            ),
          ],
        ),
        body: GestureDetector(
            child: Container(
          child: Column(
            children: [
              FriendsPageWidget(),
              SizedBox(height: _sizing.height(1)),
              Expanded(child: friendListWidget),
            ],
          ),
        )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('好友', style: TextStyle(fontSize: _titleSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                await friendsAddDialog(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          bottom: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }

  Widget _buildSearchBestFriendList(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(6);
    double _pSize = _sizing.height(2.3);

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredBestFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredBestFriend[index];
        return ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: _pSize),
          ),
          trailing: TextButton(
              style: TextButton.styleFrom(primary: Color(0xffF86D67)),
              child: Text(
                '移除',
                style: TextStyle(fontSize: _pSize),
              ),
              onPressed: () async {}),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchFriendList(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(6);
    double _pSize = _sizing.height(2.3);
    _submitDelete(String friendId) async {
      var submitWidget;

      _submitWidgetfunc() async {
        return DeleteFriend(uid: uid, friendId: friendId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredFriend[index];
        return ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: TextButton(
              child: Text(
                friends.friendName,
                style: TextStyle(fontSize: _pSize),
              ),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HomeUpdate(child: FriendHome(friends.friendId))));
              }),
          trailing: TextButton(
              style: TextButton.styleFrom(primary: Color(0xffF86D67)),
              child: Text(
                '移除',
                style: TextStyle(fontSize: _pSize),
              ),
              onPressed: () async {
                if (await _submitDelete(friends.friendId) != true) {
                  _friendListRequest();
                }
              }),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}

class FriendsPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _titleSize = _sizing.height(2.5);
    double _bottomHeight = _sizing.height(7);

    return Container(
        child: Column(children: <Widget>[
      Container(
        margin:
            EdgeInsets.only(top: _sizing.height(1), left: _sizing.height(1.8)),
        child: SizedBox(
            height: _bottomHeight,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BestfriendPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '摯友',
                    style: TextStyle(
                      fontSize: _titleSize,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            )),
      ),
      Container(
        margin: EdgeInsets.only(top: _sizing.height(0.1)),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
      Container(
        margin:
            EdgeInsets.only(top: _sizing.height(1), left: _sizing.height(1.8)),
        child: SizedBox(
            height: _bottomHeight,
            width: double.infinity,
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendInvitationPage()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '交友邀請',
                    style: TextStyle(
                      fontSize: _titleSize,
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffE3E3E3),
                  )
                ],
              ),
            )),
      ),
      Container(
        margin: EdgeInsets.only(top: _sizing.height(0.1)),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
    ]));
  }
}
