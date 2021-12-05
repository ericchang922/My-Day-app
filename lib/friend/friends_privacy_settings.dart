import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/models/setting/get_friend_privacy.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/public/setting_request/friend_privacy.dart';
import 'package:My_Day_app/public/setting_request/get_friend_privacy.dart';
import 'package:My_Day_app/public/sizing.dart';

class FriendsPrivacySettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendsPrivacySettings();
  }
}

class FriendsPrivacySettings extends State {
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
  GetFriendPrivacyModel _friendprivacy;

  final _friendNameController = TextEditingController();

  String _searchText = "";
  String id;
  String friendId;

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];

  bool _isCheck;

  @override
  void initState() {
    super.initState();

    _friendListRequest();
    _bestFriendListRequest();
    _friendNameControlloer();
    _getFriendPrivacyRequest();
    _isCheck = false;
  }

  _getFriendPrivacyRequest() async {
    GetFriendPrivacyModel _request =
        await GetFriendPrivacy(context: context, uid: id, friendId: friendId)
            .getData();

    setState(() {
      _friendprivacy = _request;
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
        await BestFriendList(context: context, uid: id).getData();

    setState(() {
      _bestFriendListModel = _request;

      for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
        _bestFriendCheck[_bestFriendListModel.friend[i].friendId] = false;
      }
    });
  }

  _friendListRequest() async {
    FriendListModel _request =
        await FriendList(context: context, uid: id).getData();

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
    double _titleSize = _sizing.height(2.5);
    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    Widget friendListWidget;

    _submitfriend(String friendId) async {
      String uid = id;
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
              contentPadding: EdgeInsets.symmetric(
                  horizontal: _listPaddingH, vertical: 0.0),
              leading: ClipOval(
                child: getImage(friends.photo),
              ),
              title: Text(
                friends.friendName,
                style: TextStyle(fontSize: _pSize),
              ),
              trailing: PopupMenuButton<int>(
                  offset: Offset(0, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_sizing.height(1))),
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                        PopupMenuItem<int>(
                          value: 1,
                          child: ListTile(
                            title: Text(
                              '玩聚邀請',
                              style: TextStyle(
                                fontSize: _pSize,
                              ),
                            ),
                            trailing: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Switch(
                                value: _friendCheck[friends.friendId],
                                onChanged: (value) async {
                                  if (await _submitfriend(friends.friendId) !=
                                      true) {
                                    setState(() {
                                      _friendCheck[friends.friendId] = value;
                                    });
                                  }
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Color(0xffF86D67),
                              );
                            }),
                          ),
                        ),
                        PopupMenuDivider(
                          height: 1,
                        ),
                        PopupMenuItem<int>(
                            value: 1,
                            child: ListTile(
                              title: Text(
                                '公開課表',
                                style: TextStyle(
                                  fontSize: _pSize,
                                ),
                              ),
                              trailing: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Switch(
                                  value: _bestFriendCheck[friends.friendId],
                                  onChanged: (value) async {
                                    if (await _submitfriend(friends.friendId) !=
                                        true) {
                                      setState(() {
                                        _bestFriendCheck[friends.friendId] =
                                            value;
                                      });
                                    }
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Color(0xffF86D67),
                                );
                              }),
                            ))
                      ]));
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
            trailing: PopupMenuButton<int>(
                offset: Offset(0, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_sizing.height(1))),
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text(
                            '玩聚邀請',
                            style: TextStyle(
                              fontSize: _pSize,
                            ),
                          ),
                          trailing: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Switch(
                              value: _friendCheck[friends.friendId],
                              onChanged: (value) async {
                                if (await _submitfriend(friends.friendId) !=
                                    true) {
                                  setState(() {
                                    _friendCheck[friends.friendId] = value;
                                  });
                                }
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Color(0xffF86D67),
                            );
                          }),
                        ),
                      ),
                      PopupMenuDivider(
                        height: 1,
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text(
                            '公開課表',
                            style: TextStyle(
                              fontSize: _pSize,
                            ),
                          ),
                          trailing: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Switch(
                              value: _bestFriendCheck[friends.friendId],
                              onChanged: (value) async {
                                if (await _submitfriend(friends.friendId) !=
                                    true) {
                                  setState(() {
                                    _bestFriendCheck[friends.friendId] = value;
                                  });
                                }
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Color(0xffF86D67),
                            );
                          }),
                        ),
                      ),
                    ]),
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

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('好友隱私設定', style: TextStyle(fontSize: _titleSize)),
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
          title: Text('好友隱私設定', style: TextStyle(fontSize: _titleSize)),
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
      String uid = id;
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
          trailing: PopupMenuButton<int>(
              offset: Offset(0, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_sizing.height(1))),
              icon: Icon(Icons.more_vert),
              itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        title: Text(
                          '玩聚邀請',
                          style: TextStyle(
                            fontSize: _pSize,
                          ),
                        ),
                        trailing: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Switch(
                            value: _friendCheck[friends.friendId],
                            onChanged: (value) async {
                              if (await _submitfriend(friends.friendId) !=
                                  true) {
                                setState(() {
                                  _friendCheck[friends.friendId] = value;
                                });
                              }
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Color(0xffF86D67),
                          );
                        }),
                      ),
                    ),
                    PopupMenuDivider(
                      height: 1,
                    ),
                    PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        title: Text(
                          '公開課表',
                          style: TextStyle(
                            fontSize: _pSize,
                          ),
                        ),
                        trailing: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Switch(
                            value: _bestFriendCheck[friends.friendId],
                            onChanged: (value) async {
                              if (await _submitfriend(friends.friendId) !=
                                  true) {
                                setState(() {
                                  _bestFriendCheck[friends.friendId] = value;
                                });
                              }
                            },
                            activeColor: Colors.white,
                            activeTrackColor: Color(0xffF86D67),
                          );
                        }),
                      ),
                    ),
                  ]),
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
      String uid = id;
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
            trailing: PopupMenuButton<int>(
                offset: Offset(0, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_sizing.height(1))),
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text(
                            '玩聚邀請',
                            style: TextStyle(
                              fontSize: _pSize,
                            ),
                          ),
                          trailing: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Switch(
                              value: _friendCheck[friends.friendId],
                              onChanged: (value) async {
                                if (await _submitfriend(friends.friendId) !=
                                    true) {
                                  setState(() {
                                    _friendCheck[friends.friendId] = value;
                                  });
                                }
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Color(0xffF86D67),
                            );
                          }),
                        ),
                      ),
                      PopupMenuDivider(
                        height: 1,
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text(
                            '公開課表',
                            style: TextStyle(
                              fontSize: _pSize,
                            ),
                          ),
                          trailing: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Switch(
                              value: _bestFriendCheck[friends.friendId],
                              onChanged: (value) async {
                                if (await _submitfriend(friends.friendId) !=
                                    true) {
                                  setState(() {
                                    _bestFriendCheck[friends.friendId] = value;
                                  });
                                }
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Color(0xffF86D67),
                            );
                          }),
                        ),
                      ),
                    ]),
          );
        });
  }
}

class Block {
  final _themeContol = StreamController<bool>();

  void changeTheme1(bool value) {
    _themeContol.sink.add(value);
  }

  get darkThemeEnabled => _themeContol.stream;
}

final block = Block();
