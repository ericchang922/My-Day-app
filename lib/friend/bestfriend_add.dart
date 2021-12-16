import 'package:My_Day_app/public/friend_request/add_best.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/home/home_Update.dart';
import 'package:My_Day_app/friend/friend_home.dart';
import 'package:My_Day_app/friend/friends_add.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/public/sizing.dart';

class BestFriendAddPage extends StatefulWidget {
  @override
  _BestFriendAddWidget createState() => new _BestFriendAddWidget();
}

class _BestFriendAddWidget extends State<BestFriendAddPage> {
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
        return AddBestFriend(uid: uid, friendId: friendId);
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
              child: _getImage.friend(friends.photo),
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
            trailing: TextButton(
                style: TextButton.styleFrom(primary: Color(0xffF86D67)),
                child: Text(
                  '新增',
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

      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('新增摯友', style: TextStyle(fontSize: _titleSize)),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(children: [
            SizedBox(height: _sizing.height(1)),
            friendList,
          ]));
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('新增摯友', style: TextStyle(fontSize: _titleSize)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ),
        body: SafeArea(
          bottom: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
  }
}
