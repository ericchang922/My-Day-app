import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/public/group_request/create_group.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';

class GroupCreatePage extends StatefulWidget {
  @override
  _GroupCreateWidget createState() => new _GroupCreateWidget();
}

class _GroupCreateWidget extends State<GroupCreatePage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _friendListRequest();
    await _bestFriendListRequest();
    _friendNameControlloer();
  }

  FriendListModel _friendListModel;
  BestFriendListModel _bestFriendListModel;

  List<String> typeNameList = <String>[
    '讀書',
    '工作',
    '會議',
    '休閒',
    '社團',
    '吃飯',
    '班級'
  ];

  final _groupNameController = TextEditingController();
  final _friendNameController = TextEditingController();

  String _groupName = "";
  String _searchText = "";
  String _dropdownValue = '讀書';

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _filteredFriend = [];
  List _filteredBestFriend = [];

  bool _isNotCreate = false;

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

    double _listLR = _height * 0.02;
    double _textFied = _height * 0.045;
    double _borderRadius = _height * 0.01;
    double _iconWidth = _width * 0.05;
    double _listPaddingH = _width * 0.06;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;

    double _pSize = _height * 0.023;
    double _subtitleSize = _height * 0.02;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff707070);

    Widget friendListWidget;

    Color getTypeColor(value) {
      Color color = value == null ? Color(0xffFFFFFF) : typeColor(value);
      return color;
    }

    _submit() async {
      String _alertTitle = '新增群組失敗';
      String groupName = _groupName;
      int type = typeNameList.indexOf(_dropdownValue) + 1;

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
      if (groupName == null || groupName == '') {
        await alert(context, _alertTitle, '請輸入群組名稱');
        _isNotCreate = true;
      }
      if (_isNotCreate) {
        _isNotCreate = false;
        return true;
      } else {
        var submitWidget;
        _submitWidgetfunc() async {
          return CreateGroup(
              uid: uid, groupName: groupName, type: type, friend: friend);
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
          return true;
        else
          return false;
      }
    }

    Widget groupName = Column(children: [
      Container(
        margin: EdgeInsets.only(
          left: _listLR,
          bottom: _listLR,
          top: _height * 0.01,
          right: _listLR,
        ),
        child: Row(
          children: [
            Text('群組名稱：', style: TextStyle(fontSize: _pSize)),
            Flexible(
              child: Container(
                height: _textFied,
                child: TextField(
                  style: TextStyle(fontSize: _pSize),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: _height * 0.01, vertical: _height * 0.01),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(_borderRadius)),
                        borderSide: BorderSide(color: _bule),
                      )),
                  controller: _groupNameController,
                  onChanged: (text) {
                    setState(() {
                      _groupName = _groupNameController.text;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ]);

    Widget groupType = Container(
      margin:
          EdgeInsets.only(left: size.height * 0.02, right: size.height * 0.02),
      child: Row(
        children: [
          Text('類別：', style: TextStyle(fontSize: _pSize)),
          Container(
            height: _textFied,
            padding:
                EdgeInsets.symmetric(horizontal: _width * 0.02, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_borderRadius),
              border: Border.all(
                  color: _textFiedBorder,
                  style: BorderStyle.solid,
                  width: _width * 0.0015),
            ),
            child: DropdownButton<String>(
              icon: Icon(
                Icons.expand_more,
                color: Color(0xffcccccc),
              ),
              value: _dropdownValue,
              iconSize: _iconWidth,
              elevation: 16,
              underline: Container(height: 0),
              onChanged: (String newValue) {
                setState(() {
                  _dropdownValue = newValue;
                });
              },
              items: typeNameList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: _height * 0.01),
                          child: CircleAvatar(
                              radius: _borderRadius,
                              backgroundColor: getTypeColor(
                                  typeNameList.indexOf(value) + 1)),
                        ),
                        Text(value, style: TextStyle(fontSize: _pSize)),
                      ],
                    ));
              }).toList(),
            ),
          )
        ],
      ),
    );

    Widget search = Column(
      children: [
        Container(
          margin:
              EdgeInsets.only(bottom: _listLR, left: _listLR, right: _listLR),
          alignment: Alignment.centerLeft,
          child: Text('選擇好友', style: TextStyle(fontSize: _pSize)),
        ),
        Container(
          margin: EdgeInsets.only(right: _listLR, left: _height * 0.01),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: _height * 0.01),
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
                            horizontal: _height * 0.01,
                            vertical: _height * 0.01),
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
        ),
      ],
    );

    Widget checkAll = Container(
      margin: EdgeInsets.only(right: _width * 0.05),
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
              child: getImage(friends.photo),
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
              title: Text('建立群組', style: TextStyle(fontSize: _appBarSize)),
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
                    margin: EdgeInsets.only(top: _height * 0.02),
                    child: Column(
                      children: [
                        groupName,
                        groupType,
                        SizedBox(height: _height * 0.01),
                        Divider(),
                        SizedBox(height: _height * 0.01),
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
                              if (await _submit() != true) {
                                Navigator.pop(context);
                              }
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
              title: Text('建立群組', style: TextStyle(fontSize: _appBarSize)),
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
              child: Center(
                  child:
                      SafeArea(top: false, child: CircularProgressIndicator())),
            ),
          ),
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
