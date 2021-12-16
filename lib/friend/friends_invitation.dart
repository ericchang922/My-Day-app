import 'package:flutter/material.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/models/friend/make_friend_invite_list_model.dart';
import 'package:My_Day_app/public/friend_request/add-friend-reply.dart';
import 'package:My_Day_app/public/friend_request/make_friend_invite_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

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

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _titleSize = _sizing.height(2.5);
    double _listPaddingH = _sizing.width(6);
    double _widthSize = _sizing.width(1);
    double _pSize = _sizing.height(2.3);

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);

    Widget friendListWidget;

    GetImage _getImage = GetImage(context);

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
                child: _getImage.friend(friends.photo),
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
            margin: EdgeInsets.only(top: _sizing.height(2)),
            child: Column(
              children: [
                SizedBox(height: _sizing.height(1)),
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
    Sizing _sizing = Sizing(context);
    double _widthSize = _sizing.width(1);
    double _pSize = _sizing.height(2.3);

    Color _color = Theme.of(context).primaryColor;
    Color _gray = Color(0xff959595);
    double _listPaddingH = _sizing.width(6);

    GetImage _getImage = GetImage(context);

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
              child: _getImage.friend(friends.photo),
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
