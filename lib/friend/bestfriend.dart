import 'dart:convert';

import 'package:My_Day_app/friend/bestfriend.dart';
import 'package:My_Day_app/friend/friends_add.dart';
import 'package:My_Day_app/friend/friends_invitation.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';

import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/group_request/create_group.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';

class BestfriendPage extends StatefulWidget {
  @override
  _BestfriendWidget createState() => new _BestfriendWidget();
}

class _BestfriendWidget extends State<BestfriendPage> {
  FriendListModel _friendListModel;
  BestFriendListModel _bestFriendListModel;

  final _friendNameController = TextEditingController();

  String _searchText = "";
  String _dropdownValue = '讀書';
  String uid = 'lili123';

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];

  bool _isNotCreate = false;
  bool viewVisible = true;
  @override
  void initState() {
    super.initState();

    _friendListRequest();
    _bestFriendListRequest();
    _friendNameControlloer();
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

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  _bestFriendListRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/best_friend_list.json');
    // var responseBody = json.decode(response);

    BestFriendListModel _request = await BestFriendList(uid: uid).getData();

    setState(() {
      _bestFriendListModel = _request;

      for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
        _bestFriendCheck[_bestFriendListModel.friend[i].friendId] = false;
      }
    });
  }

  _friendListRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/friend_list.json');
    // var responseBody = json.decode(response);

    FriendListModel _request = await FriendList(uid: uid).getData();

    setState(() {
      _friendListModel = _request;

      for (int i = 0; i < _friendListModel.friend.length; i++) {
        _friendCheck[_friendListModel.friend[i].friendId] = false;
      }
    });
  }

  Image getImage(String imageString) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _imgSize = _height * 0.045;
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
      print('error');
    }));

    if (isGetImage == null) {
      return image;
    } else {
      return friendImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _leadingL = _height * 0.02;

    double _pSize = _height * 0.023;

    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;

    Color _bule = Color(0xff7AAAD8);

    Widget friendListWidget;

    _submit() async {
      String _alertTitle = '新增群組失敗';

      List<Map<String, dynamic>> friend = [];
      for (int i = 0; i < _friendListModel.friend.length; i++) {
        var _friend = _friendListModel.friend[i];
        if (_friendCheck[_friend.friendId] == true)
          friend.add({'friendId': _friend.friendId});
      }
      for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
        var _friend = _bestFriendListModel.friend[i];

        if (_bestFriendCheck[_friend.friendId] == true)
          friend.add({'friendId': _friend.friendId});
      }

      if (uid == null) {
        await alert(context, _alertTitle, '請先登入');
        _isNotCreate = true;
        Navigator.pop(context);
      }

      if (_isNotCreate) {
        _isNotCreate = false;
        return true;
      } else {
        var submitWidget;
        _submitWidgetfunc() async {
          return CreateGroup(uid: uid, friend: friend);
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
          return true;
        else
          return false;
      }
    }

    if (_friendListModel != null && _bestFriendListModel != null) {
      Widget bestFriendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _bestFriendListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _bestFriendListModel.friend[index];
          return AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: hideWidget != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            // The green box must be a child of the AnimatedOpacity widget.
          child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child: getImage(friends.photo),
            ),
            title: Text(
              friends.friendName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: FlatButton(
              child: Text(
                '移除',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Color(0xffF86D67),
              onPressed: hideWidget,
            ),
          ));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget friendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _friendListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _friendListModel.friend[index];
          return AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: hideWidget != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            // The green box must be a child of the AnimatedOpacity widget.
              child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            leading: ClipOval(
              child: getImage(friends.photo),
            ),
            title: Text(
              friends.friendName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: FlatButton(
              child: Text(
                '移除',
                style: TextStyle(fontSize: 18),
              ),
              textColor: Color(0xffF86D67),
              onPressed: hideWidget,
            ),
          ));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      if (_searchText.isEmpty) {
        if (_bestFriendListModel.friend.length != 0 &&
            _friendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [
              // Container(
              //   margin: EdgeInsets.only(
              //       left: _textL, bottom: _textBT, top: _textBT),
              //   child: Text('摯友',
              //       style: TextStyle(fontSize: _pSize, color: _bule)),
              // ),
              bestFriendList,

              // friendList
            ],
          );
        } else if (_bestFriendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [
              // Container(
              //   margin: EdgeInsets.only(
              //       left: _textL, bottom: _textBT, top: _textBT),
              //   child: Text('摯友',
              //       style: TextStyle(fontSize: _pSize, color: _bule)),
              // ),
              bestFriendList
            ],
          );
        } else if (_friendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [
              // friendList
            ],
          );
        } else {
          friendListWidget = Center(child: Text('目前沒有任何好友!'));
        }
      } else {
        // ignore: deprecated_member_use
        _filteredBestFriend = new List();
        // ignore: deprecated_member_use
        _filteredFriend = new List();

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
            children: [
              _buildSearchBestFriendList(context),
              Divider(),
              _buildSearchFriendList(context)
            ],
          );
        } else {
          friendListWidget = ListView(
            children: [
              if (_filteredBestFriend.length > 0)
                _buildSearchBestFriendList(context),
              if (_filteredFriend.length > 0) _buildSearchFriendList(context)
            ],
          );
        }
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('摯友', style: TextStyle(fontSize: 20)),
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
                bool action = await friendsAddDialog(context);
              },
            ),
          ],
        ),
        body: GestureDetector(
            child: Container(
          margin: EdgeInsets.only(top: _height * 0.02),
          child: Column(
            children: [
              SizedBox(height: _height * 0.01),
              Expanded(child: friendListWidget),
            ],
          ),
        )),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('摯友', style: TextStyle(fontSize: 20)),
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
                bool action = await friendsAddDialog(context);
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
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _listPaddingH = _width * 0.06;
    double _pSize = _height * 0.023;

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredBestFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredBestFriend[index];
        return AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: hideWidget != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            // The green box must be a child of the AnimatedOpacity widget.
          child:ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: _pSize),
          ),
          trailing: FlatButton(
            child: Text(
              '移除',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Color(0xffF86D67),
            onPressed: hideWidget,
          ),
        ));
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchFriendList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _listPaddingH = _width * 0.06;
    double _pSize = _height * 0.023;

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredFriend[index];
        return AnimatedOpacity(
            // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
            opacity: hideWidget != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            // The green box must be a child of the AnimatedOpacity widget.
          child:ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: _pSize),
          ),
          trailing: FlatButton(
            child: Text(
              '移除',
              style: TextStyle(fontSize: 18),
            ),
            textColor: Color(0xffF86D67),
            onPressed: hideWidget,
          ),
        ));
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
