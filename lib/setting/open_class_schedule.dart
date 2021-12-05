import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/models/setting/get_timetable.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/setting_request/friend_privacy.dart';
import 'package:My_Day_app/public/setting_request/get_timetable.dart';
import 'package:My_Day_app/public/setting_request/privacy_timetable.dart';
import 'package:My_Day_app/public/sizing.dart';

const PrimaryColor = const Color(0xFFF86D67);

class OpenClassSchedulePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OpenClassSchedulePage();
  }
}

class _OpenClassSchedulePage extends State {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return friendPage();
  }
}

class friendPage extends StatefulWidget {
  @override
  _friendWidget createState() => new _friendWidget();
}

class _friendWidget extends State<friendPage> {
  FriendListModel _friendListModel;
  BestFriendListModel _bestFriendListModel;
  GetTimetableModel _timetable;

  final _friendNameController = TextEditingController();

  String _searchText = "";
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _friendListRequest();
    await _bestFriendListRequest();
    await _getTimetableRequest();

    if (_timetable == null) {
      _isCheck = false;
    } else {
      _isCheck = _timetable.timetable;
    }
  }

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];

  bool _isCheck;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getTimetableRequest() async {
    GetTimetableModel _request =
        await GetTimetable(context: context, uid: uid).getData();

    setState(() {
      _timetable = _request;
      print(_timetable);
      print("_timetable");
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
    FriendListModel _request = await FriendList(uid: uid).getData();

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
    Sizing _sizing = Sizing(context);
    double _appBarSize = _sizing.width(5.2);
    double _bottomHeight = _sizing.height(7);
    double _listPaddingH = _sizing.width(6);
    double _pSize = _sizing.height(2.3);

    Widget friendListWidget;

    _submitTimetable() async {
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return PrivacyTimetable(uid: uid, isPublic: isPublic);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _submitfriend(String friendId) async {
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return FriendPrivacy(uid: uid, friendId: friendId, isPublic: isPublic);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    if (_friendListModel != null && _bestFriendListModel != null) {
      Widget bestFriendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _bestFriendListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _bestFriendListModel.friend[index];
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
            trailing: Switch(
              value: _bestFriendCheck[friends.friendId],
              onChanged: (value) async {
                if (await _submitfriend(friends.friendId) != true) {
                  setState(() {
                    _friendCheck[friends.friendId] = value;
                  });
                }
              },
              activeColor: Colors.white,
              activeTrackColor: Color(0xffF86D67),
            ),
          );
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
            trailing: Switch(
              value: _friendCheck[friends.friendId],
              onChanged: (value) async {
                if (await _submitfriend(friends.friendId) != true) {
                  setState(() {
                    _friendCheck[friends.friendId] = value;
                  });
                }
              },
              activeColor: Colors.white,
              activeTrackColor: Color(0xffF86D67),
            ),
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
            children: [bestFriendList, friendList],
          );
        } else if (_bestFriendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [bestFriendList],
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
      Widget playtogetherinvite = Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: 0, right: _sizing.height(1.8), left: _sizing.height(1.8)),
          child: SizedBox(
              height: _bottomHeight,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '公開課表',
                      style: TextStyle(
                        fontSize: _appBarSize,
                      ),
                    ),
                    Switch(
                      value: _isCheck,
                      onChanged: (value) async {
                        if (await _submitTimetable() != true) {
                          setState(() {
                            if (_isCheck = value) {
                              _isCheck = true;
                              for (int i = 0;
                                  i < _friendListModel.friend.length;
                                  i++) {
                                _friendCheck[
                                    _friendListModel.friend[i].friendId] = true;
                              }
                              for (int i = 0;
                                  i < _bestFriendListModel.friend.length;
                                  i++) {
                                _bestFriendCheck[_bestFriendListModel
                                    .friend[i].friendId] = true;
                              }
                            } else {
                              _isCheck = false;
                              for (int i = 0;
                                  i < _friendListModel.friend.length;
                                  i++) {
                                _friendCheck[_friendListModel
                                    .friend[i].friendId] = false;
                              }
                              for (int i = 0;
                                  i < _bestFriendListModel.friend.length;
                                  i++) {
                                _bestFriendCheck[_bestFriendListModel
                                    .friend[i].friendId] = false;
                              }
                            }
                          });
                        }
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Color(0xffF86D67),
                    ),
                  ],
                ),
              )),
        ),
        Container(
          margin: EdgeInsets.only(top: _sizing.height(0.1)),
          color: Color(0xffE3E3E3),
          constraints: BoxConstraints.expand(height: 1.0),
        ),
      ]);

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('公開課表', style: TextStyle(fontSize: _appBarSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: GestureDetector(
              child: Container(
            margin: EdgeInsets.only(top: _sizing.height(2)),
            child: Column(
              children: [
                playtogetherinvite,
                Expanded(child: friendListWidget),
              ],
            ),
          )),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('公開課表', style: TextStyle(fontSize: _appBarSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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

    _submitfriend(String friendId) async {
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return FriendPrivacy(uid: uid, friendId: friendId, isPublic: isPublic);
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
          trailing: Switch(
            value: _bestFriendCheck[friends.friendId],
            onChanged: (value) async {
              if (await _submitfriend(friends.friendId) != true) {
                setState(() {
                  _friendCheck[friends.friendId] = value;
                });
              }
            },
            activeColor: Colors.white,
            activeTrackColor: Color(0xffF86D67),
          ),
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

    _submitfriend(String friendId) async {
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return FriendPrivacy(uid: uid, friendId: friendId, isPublic: isPublic);
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
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: _pSize),
          ),
          trailing: Switch(
            value: _friendCheck[friends.friendId],
            onChanged: (value) async {
              if (await _submitfriend(friends.friendId) != true) {
                setState(() {
                  _friendCheck[friends.friendId] = value;
                });
              }
            },
            activeColor: Colors.white,
            activeTrackColor: Color(0xffF86D67),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
