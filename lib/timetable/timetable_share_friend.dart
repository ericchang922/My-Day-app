import 'package:flutter/material.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class TimetableShareFriendPage extends StatefulWidget {
  int timetableNo;
  TimetableShareFriendPage(this.timetableNo);

  @override
  _TimetableShareFriendWidget createState() =>
      new _TimetableShareFriendWidget(timetableNo);
}

class _TimetableShareFriendWidget extends State<TimetableShareFriendPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _friendListRequest();
    _friendNameControlloer();
  }

  int timetableNo;
  _TimetableShareFriendWidget(this.timetableNo);

  FriendListModel _friendListModel;
  BestFriendListModel _bestFriendListModel;

  final _friendNameController = TextEditingController();

  String _searchText = "";

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];

  @override
  void initState() {
    super.initState();
    _uid();
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

  _friendListRequest() async {
    FriendListModel _friendRequest = await FriendList(uid: uid).getData();
    BestFriendListModel _bestFriendRequest =
        await BestFriendList(context: context, uid: uid).getData();

    setState(() {
      _friendListModel = _friendRequest;
      _bestFriendListModel = _bestFriendRequest;

      for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
        _bestFriendCheck[_bestFriendListModel.friend[i].friendId] = false;
      }
      for (int i = 0; i < _friendListModel.friend.length; i++) {
        _friendCheck[_friendListModel.friend[i].friendId] = false;
      }
    });
  }

  friendCheckCount() {
    int count = 0;
    for (int i = 0; i < _friendListModel.friend.length; i++) {
      var _friend = _friendListModel.friend[i];
      if (_friendCheck[_friend.friendId] == true) count++;
    }
    for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
      var _friend = _bestFriendListModel.friend[i];

      if (_bestFriendCheck[_friend.friendId] == true) count++;
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listLR = _sizing.height(2);
    double _textFied = _sizing.height(4.5);
    double _borderRadius = _sizing.height(1);
    double _iconWidth = _sizing.width(5);
    double _listPaddingH = _sizing.width(6);
    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);

    double _pSize = _sizing.height(2.3);
    double _subtitleSize = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    Widget friendListWidget;

    GetImage _getImage = GetImage(context);

    Widget search = Container(
      margin: EdgeInsets.only(right: _listLR, left: _sizing.height(1)),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: _sizing.height(1)),
            child: IconButton(
              icon: Image.asset(
                'assets/images/search.png',
                width: _iconWidth,
              ),
              onPressed: () {},
            ),
          ),
          Flexible(
            child: Container(
              height: _textFied,
              child: TextField(
                style: TextStyle(fontSize: _pSize),
                decoration: InputDecoration(
                    hintText: '輸入好友名稱搜尋',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: _sizing.height(1),
                        vertical: _sizing.height(1)),
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius)),
                      borderSide: BorderSide(
                        color: _textFiedBorder,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(Radius.circular(_borderRadius)),
                      borderSide: BorderSide(color: _bule),
                    )),
                controller: _friendNameController,
              ),
            ),
          ),
        ],
      ),
    );

    Widget checkAll = Container(
      margin: EdgeInsets.only(right: _sizing.width(5)),
      alignment: Alignment.centerRight,
      child: InkWell(
        child: Text('全選', style: TextStyle(fontSize: _subtitleSize)),
        onTap: () {
          setState(() {
            if (_friendNameController.text.isEmpty) {
              for (int i = 0; i < _friendListModel.friend.length; i++) {
                _friendCheck[_friendListModel.friend[i].friendId] = true;
              }
              for (int i = 0; i < _bestFriendListModel.friend.length; i++) {
                _bestFriendCheck[_bestFriendListModel.friend[i].friendId] =
                    true;
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
              child: _getImage.friend(friends.photo),
            ),
            title: Text(
              friends.friendName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: CustomerCheckBox(
                value: _bestFriendCheck[friends.friendId],
                onTap: (value) {
                  setState(() {
                    _bestFriendCheck[friends.friendId] = value;
                  });
                }),
            onTap: () {
              if (_bestFriendCheck[friends.friendId] == false) {
                setState(() {
                  _bestFriendCheck[friends.friendId] = true;
                });
              } else {
                setState(() {
                  _bestFriendCheck[friends.friendId] = false;
                });
              }
            },
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
              child: _getImage.friend(friends.photo),
            ),
            title: Text(
              friends.friendName,
              style: TextStyle(fontSize: _pSize),
            ),
            trailing: CustomerCheckBox(
              value: _friendCheck[friends.friendId],
              onTap: (value) {
                if (friendCheckCount() == 0 ||
                    _friendCheck[friends.friendId] == true) {
                  setState(() {
                    _friendCheck[friends.friendId] = value;
                  });
                }
              },
            ),
            onTap: () {
              if (_friendCheck[friends.friendId] == false) {
                setState(() {
                  _friendCheck[friends.friendId] = true;
                });
              } else {
                setState(() {
                  _friendCheck[friends.friendId] = false;
                });
              }
            },
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
              Container(
                margin: EdgeInsets.only(
                    left: _textL, bottom: _textBT, top: _textBT),
                child: Text('摯友',
                    style: TextStyle(fontSize: _pSize, color: _bule)),
              ),
              bestFriendList,
              Container(
                margin: EdgeInsets.only(
                    left: _textL, bottom: _textBT, top: _textBT),
                child: Text('好友',
                    style: TextStyle(fontSize: _pSize, color: _bule)),
              ),
              friendList
            ],
          );
        } else if (_bestFriendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: _textL, bottom: _textBT, top: _textBT),
                child: Text('摯友',
                    style: TextStyle(fontSize: _pSize, color: _bule)),
              ),
              bestFriendList
            ],
          );
        } else if (_friendListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: _textL, bottom: _textBT, top: _textBT),
                child: Text('好友',
                    style: TextStyle(fontSize: _pSize, color: _bule)),
              ),
              friendList
            ],
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

      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('選擇好友', style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            body: GestureDetector(
              // 點擊空白處釋放焦點
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Container(
                  color: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(top: _sizing.height(2)),
                    child: Column(
                      children: [
                        search,
                        checkAll,
                        Expanded(child: friendListWidget),
                      ],
                    ),
                  )),
            ),
            bottomNavigationBar: Container(
              color: Theme.of(context).bottomAppBarColor,
              child: SafeArea(
                top: false,
                child: BottomAppBar(
                  elevation: 0,
                  child: Row(children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: _bottomHeight,
                        child: RawMaterialButton(
                            elevation: 0,
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: _iconWidth,
                            ),
                            fillColor: _light,
                            onPressed: () => Navigator.pop(context)),
                      ),
                    ), // 取消按鈕
                    Expanded(
                      child: SizedBox(
                        height: _bottomHeight,
                        child: RawMaterialButton(
                            elevation: 0,
                            child: Image.asset(
                              'assets/images/confirm.png',
                              width: _iconWidth,
                            ),
                            fillColor: _color,
                            onPressed: () async {
                              // if (await _submit() != true) {
                              //   Navigator.pop(context);
                              // }
                            }),
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('選擇好友', style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            body: Container(
              color: Colors.white,
              child: SafeArea(
                  top: false,
                  child: Center(child: CircularProgressIndicator())),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSearchBestFriendList(BuildContext context) {
    Sizing _sizing = Sizing(context);

    GetImage _getImage = GetImage(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredBestFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredBestFriend[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _sizing.width(5.5), vertical: 0.0),
          leading: ClipOval(
            child: _getImage.friend(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: _sizing.width(4.1)),
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
            if (_bestFriendCheck[friends.friendId] == false) {
              setState(() {
                _bestFriendCheck[friends.friendId] = true;
              });
            } else {
              setState(() {
                _bestFriendCheck[friends.friendId] = false;
              });
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchFriendList(BuildContext context) {
    Sizing _sizing = Sizing(context);

    GetImage _getImage = GetImage(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredFriend[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: _sizing.width(5.5), vertical: 0.0),
          leading: ClipOval(
            child: _getImage.friend(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: _sizing.width(4.1)),
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
            if (_friendCheck[friends.friendId] == false) {
              setState(() {
                _friendCheck[friends.friendId] = true;
              });
            } else {
              setState(() {
                _friendCheck[friends.friendId] = false;
              });
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
