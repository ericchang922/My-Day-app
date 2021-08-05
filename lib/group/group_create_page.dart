import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/models/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customer_check_box.dart';

class GroupCreatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:
            Text('建立群組', style: TextStyle(fontSize: screenSize.width * 0.052)),
        leading: Container(
          margin: EdgeInsets.only(left: screenSize.height * 0.02),
          child: GestureDetector(
            child: Icon(Icons.chevron_left),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Container(color: Colors.white, child: GroupCreateWidget()),
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
  FriendListModel _friendListModel = null;
  BestFriendListModel _bestFriendListModel = null;

  bool _isEnabled;

  @override
  void initState() {
    super.initState();

    _friendListRequest();
    _bestFriendListRequest();
    _buttonIsOnpressed();
  }

  void _bestFriendListRequest() async {
    // var reponse = await rootBundle.loadString('assets/json/best_friend_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/friend/best_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var bestFriendListModel = BestFriendListModel.fromJson(jsonBody);

    setState(() {
      _bestFriendListModel = bestFriendListModel;

      for (int i = 0; i < bestFriendListModel.friend.length; i++) {
        _bestFriendCheck[bestFriendListModel.friend[i].friendId] = false;
      }
    });
  }

  void _friendListRequest() async {
    // var jsonString = await rootBundle.loadString('assets/json/friend_list.json');

    var httpClient = HttpClient();
    var request = await httpClient.getUrl(
        Uri.http('myday.sytes.net', '/friend/friend_list/', {'uid': uid}));
    var response = await request.close();
    var jsonString = await response.transform(utf8.decoder).join();
    httpClient.close();

    var jsonBody = json.decode(jsonString);

    var friendListModel = FriendListModel.fromJson(jsonBody);

    setState(() {
      _friendListModel = friendListModel;

      for (int i = 0; i < friendListModel.friend.length; i++) {
        _friendCheck[friendListModel.friend[i].friendId] = false;
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

  _buttonIsOnpressed() {
    if (_groupNameController.text.isEmpty) {
      setState(() {
        _isEnabled = false;
      });
    } else {
      setState(() {
        _isEnabled = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: screenSize.height * 0.02),
      child: Column(
        children: [
          _buildGroupName(context),
          _buildType(context),
          SizedBox(height: screenSize.height * 0.01),
          Divider(),
          SizedBox(height: screenSize.height * 0.01),
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
    var screenSize = MediaQuery.of(context).size;
    return Column(children: [
      Container(
        margin: EdgeInsets.only(
          left: screenSize.height * 0.02,
          bottom: screenSize.height * 0.02,
          top: screenSize.height * 0.02,
          right: screenSize.height * 0.02,
        ),
        child: Row(
          children: [
            Text('群組名稱：', style: TextStyle(fontSize: screenSize.width * 0.041)),
            Flexible(
              child: Container(
                height: 40.0,
                child: TextField(
                  style: TextStyle(fontSize: screenSize.width * 0.041),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenSize.height * 0.01,
                          vertical: screenSize.height * 0.01),
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
                    _buttonIsOnpressed();
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
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          left: screenSize.height * 0.02, right: screenSize.height * 0.02),
      child: Row(
        children: [
          Text('類別：', style: TextStyle(fontSize: screenSize.width * 0.041)),
          Container(
            height: screenSize.height * 0.04683,
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.02, vertical: 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(screenSize.height * 0.01),
              border: Border.all(
                  color: Color(0xff707070),
                  style: BorderStyle.solid,
                  width: screenSize.width * 0.0015),
            ),
            child: DropdownButton<String>(
              icon: Icon(
                Icons.expand_more,
                color: Color(0xffcccccc),
              ),
              value: dropdownValue,
              iconSize: screenSize.width * 0.05,
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
                            margin: EdgeInsets.only(
                                right: screenSize.height * 0.01),
                            child: CircleAvatar(
                              radius: screenSize.height * 0.01,
                              backgroundColor:
                                  Color(typeColor[typeNameList.indexOf(value)]),
                            )),
                        Text(value,
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041)),
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
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          bottom: screenSize.height * 0.02,
          left: screenSize.height * 0.02,
          right: screenSize.height * 0.02),
      alignment: Alignment.centerLeft,
      child: Text('選擇好友', style: TextStyle(fontSize: screenSize.width * 0.041)),
    );
  }

  Widget _buildSearch(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
          right: screenSize.height * 0.02, left: screenSize.height * 0.01),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: screenSize.height * 0.01),
            child: IconButton(
              icon: Image.asset(
                'assets/images/search.png',
                width: screenSize.width * 0.05,
              ),
              onPressed: () {},
            ),
          ),
          Flexible(
            child: Container(
              height: screenSize.height * 0.04683,
              child: TextField(
                style: TextStyle(fontSize: screenSize.width * 0.041),
                decoration: InputDecoration(
                    hintText: '輸入好友名稱搜尋',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: screenSize.height * 0.01,
                        vertical: screenSize.height * 0.01),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenSize.height * 0.01)),
                      borderSide: BorderSide(
                        color: Color(0xff070707),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(screenSize.height * 0.01)),
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
      margin: EdgeInsets.only(right: screenSize.width * 0.03),
      alignment: Alignment.centerRight,
      child: FlatButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        padding: EdgeInsets.zero,
        height: 6,
        minWidth: 5,
        child: Text('全選', style: TextStyle(fontSize: screenSize.width * 0.035)),
        onPressed: () {
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
  }

  Widget _buildList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_searchText.isEmpty) {
      if (_friendListModel != null && _bestFriendListModel != null) {
        return ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  bottom: screenSize.width * 0.02,
                  top: screenSize.width * 0.02),
              child: Text('摯友',
                  style: TextStyle(
                      fontSize: screenSize.width * 0.041,
                      color: Color(0xff7AAAD8))),
            ),
            _buildBestFriendList(context),
            Container(
              margin: EdgeInsets.only(
                  left: screenSize.width * 0.04,
                  bottom: screenSize.width * 0.02,
                  top: screenSize.width * 0.02),
              child: Text('好友',
                  style: TextStyle(
                      fontSize: screenSize.width * 0.041,
                      color: Color(0xff7AAAD8))),
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
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _bestFriendListModel.friend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _bestFriendListModel.friend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
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

  Image getImage(String imageString) {
    var screenSize = MediaQuery.of(context).size;
    bool isGetImage;
    Image friendImage = Image.asset(
      'assets/images/friend_choose.png',
      width: screenSize.height * 0.04683,
    );
    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(base64.decode(imageString),
        width: screenSize.height * 0.04683,
        height: screenSize.height * 0.04683,
        fit: BoxFit.fill);
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

  Widget _buildFriendList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _friendListModel.friend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _friendListModel.friend[index];
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
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
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredBestFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredBestFriend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
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
    var screenSize = MediaQuery.of(context).size;
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _filteredFriend.length,
      itemBuilder: (BuildContext context, int index) {
        var friends = _filteredFriend[index];
        const Base64Codec base64 = Base64Codec();
        return ListTile(
          contentPadding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.055, vertical: 0.0),
          leading: ClipOval(
            child: getImage(friends.photo),
          ),
          title: Text(
            friends.friendName,
            style: TextStyle(fontSize: screenSize.width * 0.041),
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
    var screenSize = MediaQuery.of(context).size;
    var _onPressed;
    if (_isEnabled == true) {
      _onPressed = () {
        print("groupName:${_groupName}");
        print("type:${_type}");
        for (int i = 0; i < _friendCheck.length; i++) {
          if (_friendCheck[_friendListModel.friend[i].friendId] == false) {
            _inviteFriendList
                .add({"friendId": _friendListModel.friend[i].friendId});
          }
        }
        print(_inviteFriendList);
        Navigator.of(context).pop();
      };
    }
    return Container(
        alignment: Alignment.bottomCenter,
        child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: screenSize.height * 0.07,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Image.asset(
                'assets/images/cancel.png',
                width: screenSize.width * 0.05,
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
                disabledColor: Color(0xffCCCCCC),
                height: screenSize.height * 0.07,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Image.asset(
                  'assets/images/confirm.png',
                  width: screenSize.width * 0.05,
                ),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _onPressed);
          }))
        ]));
  }
}
