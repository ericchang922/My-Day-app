
import 'package:My_Day_app/friend/friend_home.dart';
import 'package:My_Day_app/home/home_Update.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/friend/bestfriend_add.dart';
import 'package:My_Day_app/friend/friends_add.dart';
import 'package:My_Day_app/public/friend_request/delete_best.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';

class BestfriendPage extends StatefulWidget {
  @override
  _BestfriendWidget createState() => new _BestfriendWidget();
}

class _BestfriendWidget extends State<BestfriendPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _bestFriendListRequest();
  }

  BestFriendListModel _bestFriendListModel;

  bool viewVisible = true;
  @override
  void initState() {
    super.initState();
    _uid();
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  _bestFriendListRequest() async {
    BestFriendListModel _request =
        await BestFriendList(context: context, uid: uid).getData();

    setState(() {
      _bestFriendListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _titleSize = _sizing.height(2.5);
    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    GetImage _getImage = GetImage(context);

    _submitDelete(String friendId) async {
      var submitWidget;

      _submitWidgetfunc() async {
        return DeleteBestFriend(uid: uid, friendId: friendId);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    if (_bestFriendListModel != null) {
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
                            builder: (context) => HomeUpdate(
                                child: FriendHome(friends.friendId))));
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
                      _bestFriendListRequest();
                    }
                  }));
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('摯友', style: TextStyle(fontSize: _titleSize)),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BestFriendAddPage()));
                // await bestfriendsAddDialog(context);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: GestureDetector(
              child: Container(
            margin: EdgeInsets.only(top: _sizing.height(1)),
            child: Column(
              children: [
                SizedBox(height: _sizing.height(1)),
                Expanded(child: bestFriendList),
              ],
            ),
          )),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('摯友', style: TextStyle(fontSize: _titleSize)),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BestFriendAddPage()));
                // await bestfriendsAddDialog(context);
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
