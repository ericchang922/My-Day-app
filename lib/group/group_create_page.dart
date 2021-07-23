import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_model.dart';
import 'package:My_Day_app/models/friend_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('建立群組', style: TextStyle(fontSize: 22)),
        leading: Container(
          margin: EdgeInsets.only(left: 5),
          child: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Column(children: [Expanded(child: GroupCreateWidget())]),
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

  int _type = 1;
  String _groupName = "";
  String _searchText = "";
  String dropdownValue = '讀書';
  String uid = 'lili123';

  Map<String, dynamic> _friendCheck = {};
  Map<String, dynamic> _bestFriendCheck = {};

  List _inviteFriendList = [];
  List _filteredFriend = [];
  List _filteredBestFriend = [];
  FriendModel _friendModel = null;
  BestFriendModel _bestFriendModel = null;

  @override
  void initState() {
    super.initState();

    _getFriendRequest();
    _getBestFriendRequest();
  }

  void _getBestFriendRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/best_friends.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/friend/best_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var bestFriendModel = BestFriendModel.fromJson(jsonBody);

    setState(() {
      _bestFriendModel = bestFriendModel;

      for (int i = 0; i < bestFriendModel.friend.length; i++) {
        _bestFriendCheck[bestFriendModel.friend[i].friendId] = false;
      }
    });
  }

  void _getFriendRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/friends.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/friend/friend_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var friendModel = FriendModel.fromJson(jsonBody);

    setState(() {
      _friendModel = friendModel;

      for (int i = 0; i < friendModel.friend.length; i++) {
        _friendCheck[friendModel.friend[i].friendId] = false;
      }
    });
  }

  _GroupCreateState() {
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
          _buildChooseFriendText(context),
          _buildSearch(context),
          _buildCheckAll(context),
          Expanded(child: _buildList(context)),
          _buildCheckButtom(context)
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
                child: TextFormField(
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

  Widget _buildChooseFriendText(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, left: 20, right: 20),
      alignment: Alignment.centerLeft,
      child: Text('選擇好友', style: TextStyle(fontSize: 18)),
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
              onPressed: () {},
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
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: screenSize.width*0.03),
      alignment: Alignment.centerRight,
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
              for (int i = 0; i < _friendModel.friend.length; i++) {
                _friendCheck[_friendModel.friend[i].friendId] = true;
              }
              for (int i = 0; i < _bestFriendModel.friend.length; i++) {
                _bestFriendCheck[_bestFriendModel.friend[i].friendId] = true;
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
  }

  Widget _buildList(BuildContext context) {
    if (_searchText.isEmpty) {
      if (_friendModel != null && _bestFriendModel != null) {
        return ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text('摯友',
                  style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
            ),
            _buildBestFriendList(context),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 10, top: 10),
              child: Text('好友',
                  style: TextStyle(fontSize: 16, color: Color(0xff7AAAD8))),
            ),
            _buildFriendList(context)
          ],
        );
      } else {
        return Center(child: CircularProgressIndicator());
      }
    } else {
      _filteredBestFriend = [];
      _filteredFriend = [];

      for (int i = 0; i < _friendModel.friend.length; i++) {
        if (_friendModel.friend[i].friendName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredFriend.add(_friendModel.friend[i]);
        }
      }
      for (int i = 0; i < _bestFriendModel.friend.length; i++) {
        if (_bestFriendModel.friend[i].friendName
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _filteredBestFriend.add(_bestFriendModel.friend[i]);
        }
      }

      return ListView(
        children: [
          if (_filteredBestFriend.length > 0)
            _buildSearchBestFriendList(context),
          if (_filteredFriend.length > 0) _buildSearchFriendList(context)
        ],
      );
    }
  }

  Widget _buildBestFriendList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _bestFriendModel.friend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _bestFriendModel.friend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(friends.photo), width: 40),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: 18),
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
            setState(() {
              _bestFriendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildFriendList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _friendModel.friend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _friendModel.friend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(friends.photo), width: 40),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: 18),
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
            setState(() {
              _friendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchBestFriendList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredBestFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredBestFriend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(friends.photo), width: 40),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: 18),
          ),
          trailing: CustomerCheckBox(
            value: _bestFriendCheck[friends.friendId],
            onTap: (value) {
              setState(() {
                _bestFriendCheck[friends.friendId] = value;
                print(_bestFriendCheck);
              });
            },
          ),
          onTap: () {
            setState(() {
              _bestFriendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildSearchFriendList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredFriend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 0.0),
          leading: ClipOval(
            child: Image.memory(base64.decode(friends.photo), width: 40),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: 18),
          ),
          trailing: CustomerCheckBox(
            value: _friendCheck[friends.friendId],
            onTap: (value) {
              setState(() {
                _friendCheck[friends.friendId] = value;
                print(_friendCheck);
              });
            },
          ),
          onTap: () {
            setState(() {
              _friendCheck[friends.friendId] = true;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _buildCheckButtom(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Image.asset(
                'assets/images/cancel.png',
                width: 25,
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
              child: Builder(builder: (context) {
            return FlatButton(
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Image.asset(
                  'assets/images/confirm.png',
                  width: 25,
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: () {
                  if (_groupNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("群組名稱不能為空值"),
                      action: SnackBarAction(
                        label: '確認',
                        onPressed: () {
                          ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        },
                      ),
                    ));
                  } else {
                    print(_groupName);
                    print(_type);
                    for (int i = 0; i < _friendCheck.length; i++) {
                      if (_friendCheck[_friendModel.friend[i].friendId] ==
                          false) {
                        _inviteFriendList
                            .add({"friendId": _friendModel.friend[i].friendId});
                      }
                    }
                    print(_inviteFriendList);
                    Navigator.of(context).pop();
                  }
                });
          }))
        ]));
  }
}
