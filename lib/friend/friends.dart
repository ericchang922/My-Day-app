import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/home/home_Update.dart';
import 'package:My_Day_app/friend/bestfriend.dart';
import 'package:My_Day_app/friend/friend_home.dart';
import 'package:My_Day_app/friend/friends_add.dart';
import 'package:My_Day_app/friend/friends_invitation.dart';
import 'package:My_Day_app/public/friend_request/delete.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/public/sizing.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendWidget createState() => new _FriendWidget();
}

class _FriendWidget extends State<FriendPage> {
  FriendListModel _friendListModel;
  BestFriendListModel _bestFriendListModel;

  String uid = prefs.getString('uid');

  bool viewVisible = true;

  @override
  void initState() {
    super.initState();
    _friendListRequest();
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  _friendListRequest() async {
    FriendListModel _friendRequest =
        await FriendList(context: context, uid: uid).getData();

    BestFriendListModel _bestFriendRequest =
        await BestFriendList(context: context, uid: uid).getData();

    setState(() {
      _friendListModel = _friendRequest;
      _bestFriendListModel = _bestFriendRequest;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _titleSize = _sizing.height(2.5);
    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    Color _lightGray = Color(0xffE3E3E3);

    GetImage _getImage = GetImage(context);

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

    Widget friendItem = Container(
      margin: EdgeInsets.only(top: _sizing.height(1)),
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('摯友', style: TextStyle(fontSize: _titleSize)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _lightGray,
            ),
            onTap: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BestfriendPage()))
                  .then((value) => _friendListRequest());
            },
          ),
          Divider(),
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('交友邀請', style: TextStyle(fontSize: _titleSize)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _lightGray,
            ),
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FriendInvitationPage()))
                  .then((value) => _friendListRequest());
            },
          ),
          Divider(),
        ],
      ),
    );

    if (_friendListModel != null && _bestFriendListModel != null) {
      Widget friendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _friendListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _friendListModel.friend[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            leading: Container(
              margin: EdgeInsets.only(left: _listPaddingH),
              child: ClipOval(
                child: _getImage.friend(friends.photo),
              ),
            ),
            title: InkWell(
                child: Text(
                  friends.friendName,
                  style: TextStyle(fontSize: _pSize),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeUpdate(child: FriendHome(friends.friendId))));
                }),
            trailing: PopupMenuButton(
              offset: Offset(-40, 0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_sizing.height(1))),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Container(
                        alignment: Alignment.center,
                        child: Text("刪除", style: TextStyle(fontSize: _pSize))),
                  ),
                ];
              },
              onSelected: (int value) async {
                if (await _submitDelete(friends.friendId) != true) {
                  _friendListRequest();
                }
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget bestFriendList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _bestFriendListModel.friend.length,
        itemBuilder: (BuildContext context, int index) {
          var friends = _bestFriendListModel.friend[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            leading: Container(
              margin: EdgeInsets.only(left: _listPaddingH),
              child: ClipOval(
                child: _getImage.friend(friends.photo),
              ),
            ),
            title: InkWell(
                child: Text(
                  friends.friendName,
                  style: TextStyle(fontSize: _pSize),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomeUpdate(child: FriendHome(friends.friendId))));
                }),
            trailing: PopupMenuButton(
                offset: Offset(-40, 0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(_sizing.height(1))),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 1,
                      child: Container(
                          alignment: Alignment.center,
                          child:
                              Text("刪除", style: TextStyle(fontSize: _pSize))),
                    ),
                  ];
                },
                onSelected: (int value) async {
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
          body: ListView(children: [
            friendItem,
            SizedBox(height: _sizing.height(1)),
            friendList,
            if (_bestFriendListModel.friend.length != 0 ||
                _friendListModel.friend.length != 0)
              Divider(),
            bestFriendList,
          ]));
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
}
