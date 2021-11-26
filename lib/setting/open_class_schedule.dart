import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/models/setting/get_timetable.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/public/setting_request/friend_privacy.dart';
import 'package:My_Day_app/public/setting_request/get_timetable.dart';
import 'package:My_Day_app/public/setting_request/privacy_timetable.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

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
    return SafeArea(child: Scaffold(body: friendPage()));
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
  String _dropdownValue = '讀書';
  String id = 'lili123';

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
    _getTimetableRequest();
    if (_timetable == null) {
       _isCheck = false;

      // ignore: unrelated_type_equality_checks
    } else if (_timetable == 1) {
      _isCheck = true;
    } else {
      _isCheck = false;
    }
  }
  _getTimetableRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_list.json');
    // var responseBody = json.decode(response);

    GetTimetableModel _request = await GetTimetable(uid: id).getData();

    setState(() {
      _timetable = _request;
      print(_timetable);
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
    // var reponse = await rootBundle.loadString('assets/json/best_friend_list.json');
    // var responseBody = json.decode(response);

    BestFriendListModel _request = await BestFriendList(uid: id).getData();

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

    FriendListModel _request = await FriendList(uid: id).getData();

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
    double _appBarSize = _width * 0.052;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _pSize = _height * 0.023;
    Color _color = Theme.of(context).primaryColor;

    Color _bule = Color(0xff7AAAD8);

    Widget friendListWidget;

    _submitTimetable() async {
      String uid = id;
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
      String uid = id;
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return FriendPrivacy(uid: uid,friendId: friendId, isPublic: isPublic);
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
              }},
              activeColor: Colors.white,
              activeTrackColor: Color(0xffF86D67),
              // inactiveThumbColor: Color(0xffF86D67),
              // inactiveTrackColor: Color(0xffF86D67),
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
              }},
              activeColor: Colors.white,
              activeTrackColor: Color(0xffF86D67),
              // inactiveThumbColor: Color(0xffF86D67),
              // inactiveTrackColor: Color(0xffF86D67),
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
            children: [
              // Container(
              //   margin: EdgeInsets.only(
              //       left: _textL, bottom: _textBT, top: _textBT),
              //   child: Text('摯友',
              //       style: TextStyle(fontSize: _pSize, color: _bule)),
              // ),
              bestFriendList,

              friendList
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
            children: [friendList],
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
      Widget playtogetherinvite = Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: _height * 0.00, right: _height * 0.018,left: _height * 0.018),
          // ignore: deprecated_member_use
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
                      // inactiveThumbColor: Color(0xffF86D67),
                      // inactiveTrackColor: Color(0xffF86D67),
                    ),
                  ],
                ),
              )),
        ),
        Container(
        margin: EdgeInsets.only(top: _height * 0.001),
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
        body: GestureDetector(
            child: Container(
          margin: EdgeInsets.only(top: _height * 0.02),
          child: Column(
            children: [
              playtogetherinvite,
              Expanded(child: friendListWidget),
            ],
          ),
        )),
      );
    } else {
      return SafeArea(
          child: Scaffold(
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
      ));
    }
  }

  Widget _buildSearchBestFriendList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _listPaddingH = _width * 0.06;
    double _pSize = _height * 0.023;

    _submitfriend(String friendId) async {
      String uid = id;
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return FriendPrivacy(uid: uid,friendId: friendId, isPublic: isPublic);
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
              }},
            activeColor: Colors.white,
            activeTrackColor: Color(0xffF86D67),
            // inactiveThumbColor: Color(0xffF86D67),
            // inactiveTrackColor: Color(0xffF86D67),
          ),
        );
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

    _submitfriend(String friendId) async {
      String uid = id;
      bool isPublic = _isCheck;

      var submitWidget;
      _submitWidgetfunc() async {
        return FriendPrivacy(uid: uid,friendId: friendId, isPublic: isPublic);
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
              }},
            activeColor: Colors.white,
            activeTrackColor: Color(0xffF86D67),
            // inactiveThumbColor: Color(0xffF86D67),
            // inactiveTrackColor: Color(0xffF86D67),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
