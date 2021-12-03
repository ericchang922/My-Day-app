import 'dart:convert';
import 'package:My_Day_app/models/friend/make-friend-invite-list_model.dart';
import 'package:My_Day_app/public/friend_request/add-friend-reply.dart';
import 'package:My_Day_app/public/friend_request/make-friend-invite-list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:flutter/material.dart';

class FriendInvitationPage extends StatefulWidget {
  @override
  _FriendInvitationWidget createState() => new _FriendInvitationWidget();
}

class _FriendInvitationWidget extends State<FriendInvitationPage> {
  MakeFriendInviteListModel _makefriendinviteListModel;

  final _friendNameController = TextEditingController();

  String _searchText = "";
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _makefriendinviteListRequest();
    _friendNameControlloer();
  }

  Map<String, dynamic> _friendCheck = {};

  List _filteredFriend = [];

  bool viewVisible = true;
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

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  _makefriendinviteListRequest() async {
    MakeFriendInviteListModel _request =
        await MakeFriendInviteList(context: context, uid: uid).getData();

    setState(() {
      _makefriendinviteListModel = _request;

      for (int i = 0; i < _makefriendinviteListModel.friend.length; i++) {
        _friendCheck[_makefriendinviteListModel.friend[i].friendId] = false;
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
    double _titleSize = _height * 0.025;
    double _listPaddingH = _width * 0.06;
    double _widthSize = _width * 0.01;
    double _pSize = _height * 0.023;

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);

    Widget friendListWidget;

    _submitconfirm(String friendId) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return AddFriendReply(uid: uid, friendId: friendId, relationId: 1);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _submitcancel(String friendId) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return AddFriendReply(uid: uid, friendId: friendId, relationId: 5);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    if (_makefriendinviteListModel != null) {
      Widget friendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _makefriendinviteListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _makefriendinviteListModel.friend[index];
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
              trailing: Column(children: [
                Expanded(
                    child: InkWell(
                        child: Text(
                          '確認',
                          style: TextStyle(fontSize: _pSize, color: _gray),
                        ),
                        onTap: () async {
                          if (await _submitconfirm(friends.friendId) != true) {
                            _makefriendinviteListRequest();
                          }
                        })),
                SizedBox(
                  height: _widthSize,
                ),
                Expanded(
                  child: InkWell(
                      child: Text(
                        '刪除',
                        style: TextStyle(fontSize: _pSize, color: _color),
                      ),
                      onTap: () async {
                        if (await _submitcancel(friends.friendId) != true) {
                          _makefriendinviteListRequest();
                        }
                      }),
                )
              ]));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      if (_searchText.isEmpty) {
        if (_makefriendinviteListModel.friend.length != 0) {
          friendListWidget = ListView(
            children: [friendList],
          );
        } else {
          friendListWidget = Center(child: Text('目前沒有任何好友邀請!'));
        }
      } else {
        _filteredFriend = [];

        for (int i = 0; i < _makefriendinviteListModel.friend.length; i++) {
          if (_makefriendinviteListModel.friend[i].friendName
              .toLowerCase()
              .contains(_searchText.toLowerCase())) {
            _filteredFriend.add(_makefriendinviteListModel.friend[i]);
          }
        }

        if (_filteredFriend.length > 0) {
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
          title: Text('交友邀請', style: TextStyle(fontSize: _titleSize)),
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
            margin: EdgeInsets.only(top: _height * 0.02),
            child: Column(
              children: [
                SizedBox(height: _height * 0.01),
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
          title: Text('交友邀請', style: TextStyle(fontSize: _titleSize)),
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

  Widget _buildSearchFriendList(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _widthSize = _width * 0.01;
    double _pSize = _height * 0.023;

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);
    double _listPaddingH = _width * 0.06;

    _submitconfirm(String friendId) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return AddFriendReply(uid: uid, friendId: friendId, relationId: 1);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _submitcancel(String friendId) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return AddFriendReply(uid: uid, friendId: friendId, relationId: 5);
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
            trailing: Column(children: [
              Expanded(
                  child: InkWell(
                      child: Text(
                        '確認',
                        style: TextStyle(fontSize: _pSize, color: _gray),
                      ),
                      onTap: () async {
                        if (await _submitconfirm(friends.friendId) != true) {
                          _makefriendinviteListRequest();
                        }
                      })),
              SizedBox(
                height: _widthSize,
              ),
              Expanded(
                child: InkWell(
                    child: Text(
                      '刪除',
                      style: TextStyle(fontSize: _pSize, color: _color),
                    ),
                    onTap: () async {
                      if (await _submitcancel(friends.friendId) != true) {
                        _makefriendinviteListRequest();
                      }
                    }),
              )
            ]));
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
