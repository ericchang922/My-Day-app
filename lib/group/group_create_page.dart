import 'package:My_Day_app/models/friend.dart';
import 'package:My_Day_app/models/friend_list.dart';
import 'package:My_Day_app/models/friend_service.dart';
import 'package:flutter/material.dart';

import 'customer_check_box.dart';

class GroupCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('建立群組', style: TextStyle(fontSize: 22)),
      ),
      body: Column(children: [Expanded(child: GroupCreateWidget())]),
      bottomNavigationBar: Container(
          child: Row(
        children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              color: Theme.of(context).primaryColorLight,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                '建立',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                // print(groupNameController.text);
              },
            ),
          )
        ],
      )),
    );
  }
}

class GroupCreateWidget extends StatefulWidget {
  @override
  State<GroupCreateWidget> createState() => new _GroupCreateState();
}

class _GroupCreateState extends State<GroupCreateWidget> {
  var typeNameList = <String>['讀書', '工作', '會議', '休閒', '社團', '吃飯', '班級'];

  List typeColor = <int>[
    0xffF78787,
    0xffFFD51B,
    0xffFFA800,
    0xffB6EB3A,
    0xff53DAF0,
    0xff4968BA,
    0xffCE85E4
  ];

  final _groupNameController = TextEditingController();
  final _friendNameController = TextEditingController();

  bool _bestFriendCheck = false;

  FriendList _friends = new FriendList();
  FriendList _filteredFriends = new FriendList();

  String _searchText = "";
  String dropdownValue = '讀書';

  Map<String, dynamic> _friendCheck = {};

  int count = 0;

  @override
  void initState() {
    super.initState();

    _friends.friends = new List();
    _filteredFriends.friends = new List();

    _getFriends();
  }

  void _getFriends() async {
    FriendList friends = await FriendService().loadFriends();
    setState(() {
      for (Friend friend in friends.friends) {
        this._friends.friends.add(friend);
        this._filteredFriends.friends.add(friend);
      }
    });

    _getFriendCheck();
  }

  void _getFriendCheck() {
    setState(() {
      for (int i = 0; i < _friends.friends.length; i++) {
        _friendCheck[_friends.friends[i].friendName] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          _buildGroupName(context),
          _buildType(context),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          _buildText(context),
          _buildSearch(context),
          _buildCheckAll(context),
          _buildBestFriend(context),
          Divider(),
          Expanded(child: _buildList(context)),
        ],
      ),
    );
  }

  Widget _buildGroupName(BuildContext context) {
    return Column(children: [
      Container(
        margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Row(
          children: [
            Text('群組名稱：', style: TextStyle(fontSize: 18)),
            Flexible(
              child: Container(
                height: 40.0,
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xff7AAAD8)),
                    )),
                  controller: _groupNameController,
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _buildType(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Text('類別：', style: TextStyle(fontSize: 18)),
          Container(
            height: 40.0,
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color: Color(0xff707070),
                  style: BorderStyle.solid,
                  width: 0.80),
            ),
            child: DropdownButton<String>(
              icon: Icon(
                Icons.expand_more,
                color: Color(0xffcccccc),
              ),
              value: dropdownValue,
              iconSize: 24,
              elevation: 16,
              underline: Container(height: 0),
              onChanged: (String newValue) {
                print(typeNameList.indexOf(newValue) + 1);
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: typeNameList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 10.0,
                              backgroundColor:
                                  Color(typeColor[typeNameList.indexOf(value)]),
                            )),
                        Text(value),
                      ],
                    ));
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      alignment: Alignment.centerLeft,
      child: Text('選擇好友', style: TextStyle(fontSize: 18)),
    );
  }

  Widget _buildList(BuildContext context) {
    if (!(_searchText.isEmpty)) {
      _filteredFriends.friends = new List();
      for (int i = 0; i < _friends.friends.length; i++) {
        if (_friends.friends[i].friendName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredFriends.friends.add(_friends.friends[i]);
        }
      }
    }
    return ListView(
      children: this
          ._filteredFriends
          .friends
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildSearch(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20, left: 10),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Image.asset(
                'assets/images/search.png',
                width: 25,
              ),
              onPressed: () {
                _getFriendCheck();
              },
            ),
          ),
          Flexible(
            child: Container(
              height: 40.0,
              child: TextField(
                decoration: InputDecoration(
                    hintText: '輸入好友名稱搜尋',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Color(0xff070707),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xff7AAAD8)),
                    )),
                controller: _friendNameController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckAll(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 290.0, top: 5.0),
      child: FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        height: 6,
        minWidth: 5,
        child: Text('全選', style: TextStyle(fontSize: 16)),
        onPressed: () {
          setState(() {
            if (_friendNameController.text.isEmpty) {
              for (int i = 0; i < _friends.friends.length; i++) {
                _friendCheck[_friends.friends[i].friendName] = true;
                _bestFriendCheck = true;
              }
            } else {
              for (int i = 0; i < _filteredFriends.friends.length; i++) {
                _friendCheck[_filteredFriends.friends[i].friendName] = true;
                _bestFriendCheck = true;
              }
            }
          });
        },
      ),
    );
  }

  Widget _buildBestFriend(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
      title: Container(
        margin: EdgeInsets.only(left: 30),
        child: Text(
          '摯友',
          style: TextStyle(fontSize: 18),
        ),
      ),
      trailing: CustomerCheckBox(
        value: _bestFriendCheck,
        onTap: (value) {
          setState(() {
            _bestFriendCheck = value;
          });
        },
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Friend friend) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Image.asset('assets/images/search.png'),
            height: 40,
            width: 40,
          ),
          title: Text(
            friend.friendName,
            style: TextStyle(fontSize: 18),
          ),
          trailing: CustomerCheckBox(
            value: _friendCheck[friend.friendName],
            onTap: (value) {
              setState(() {
                _friendCheck[friend.friendName] = value;
              });
            },
          ),
        ),
        Divider(),
      ],
    );
  }

  _GroupCreateState() {
    _friendNameController.addListener(() {
      if (_friendNameController.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetFriends();
        });
      } else {
        setState(() {
          _searchText = _friendNameController.text;
        });
      }
    });
  }

  void _resetFriends() {
    this._filteredFriends.friends = new List();
    for (Friend friend in _friends.friends) {
      this._filteredFriends.friends.add(friend);
    }
  }
}
