import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/schedule/schedule_form.dart';
import 'package:My_Day_app/models/friend/best_friend_list_model.dart';
import 'package:My_Day_app/models/friend/friend_list_model.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/type_color.dart';
import 'package:My_Day_app/public/friend_request/best_friend_list.dart';
import 'package:My_Day_app/public/friend_request/friend_list.dart';
import 'package:My_Day_app/public/temporary_group_request/create_group.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class TemporaryGroupCreatePage extends StatefulWidget {
  @override
  _CreateScheduleWidget createState() => new _CreateScheduleWidget();
}

class _CreateScheduleWidget extends State<TemporaryGroupCreatePage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  int _type;
  DateTime _startDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 8, 0);
  DateTime _endDateTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 9, 0);
  String _title;
  String _location;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  bool _allDay = false;
  bool _isNotCreate = false;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  Widget build(BuildContext context) {
    _titleController.text = _title;
    _locationController.text = _location;
    // values ------------------------------------------------------------------------------------------
    Sizing _sizing = Sizing(context);
    double _bottomHeight = _sizing.height(7);
    double _bottomIconWidth = _sizing.width(5);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;

    double _paddingLR = _sizing.width(6);
    double _listPaddingLR = _sizing.width(10);
    double _listItemHeight = _sizing.height(8);
    double _leadingL = _sizing.height(2);

    double _iconSize = _sizing.height(5);
    double _h1Size = _sizing.height(3.5);
    double _h2Size = _sizing.height(3);
    double _pSize = _sizing.height(2.5);
    double _timeSize = _sizing.width(4.5);
    double _appBarSize = _sizing.width(5.2);

    String _startView = _allDay
        ? '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]}'
        : '${_startDateTime.month.toString().padLeft(2, '0')} 月 ${_startDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_startDateTime.weekday - 1]} ${_startDateTime.hour.toString().padLeft(2, '0')}:${_startDateTime.minute.toString().padLeft(2, '0')}';
    String _endView = _allDay
        ? '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]}'
        : '${_endDateTime.month.toString().padLeft(2, '0')} 月 ${_endDateTime.day.toString().padLeft(2, '0')} 日 ${weekdayName[_endDateTime.weekday - 1]} ${_endDateTime.hour.toString().padLeft(2, '0')}:${_endDateTime.minute.toString().padLeft(2, '0')}';

    Color getTypeColor(value) {
      Color color = value == null ? Color(0xffFFFFFF) : typeColor(value);
      return color;
    }

    // _submit -----------------------------------------------------------------------------------------
    _submit() async {
      String _alertTitle = '新增行程失敗';
      String title = _titleController.text;
      String startTime;
      String endTime;

      int typeId = _type;
      String place = _locationController.text;
      if (place == "") place = null;

      String startTimeString =
          '${_startDateTime.year.toString()}-${_startDateTime.month.toString().padLeft(2, '0')}-${_startDateTime.day.toString().padLeft(2, '0')} 00:00:00';
      String endTimeString =
          '${_endDateTime.year.toString()}-${_endDateTime.month.toString().padLeft(2, '0')}-${_endDateTime.day.toString().padLeft(2, '0')} 23:59:59';
      if (_allDay) {
        startTime = DateTime.parse(startTimeString).toString();
        endTime = DateTime.parse(endTimeString).toString();
      } else {
        startTime = _startDateTime.toString();
        endTime = _endDateTime.toString();
      }

      if (uid == null) {
        await alert(context, _alertTitle, '請先登入');
        _isNotCreate = true;
        Navigator.pop(context);
      }
      if (title == null || title == '') {
        await alert(context, _alertTitle, '請輸入標題');
        _isNotCreate = true;
      }
      if (startTime == null || startTime == '') {
        await alert(context, _alertTitle, '請選擇開始時間');
        _isNotCreate = true;
      }

      if (endTime == null || endTime == '') {
        await alert(context, _alertTitle, '請選擇結束時間');
        _isNotCreate = true;
      }
      if (_startDateTime.isAfter(_endDateTime)) {
        await alert(context, _alertTitle, '結束時間必須在開始時間之後');
        _isNotCreate = true;
      }
      if (typeId == null || typeId <= 0 || typeId > 8) {
        await alert(context, _alertTitle, '請選擇類別');
        _isNotCreate = true;
      }
      if (_endDateTime.isBefore(DateTime.now())) {
        await alert(context, _alertTitle, '請選擇未來時間');
        _isNotCreate = true;
      }
      if (_isNotCreate) {
        _isNotCreate = false;
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                InviteFriendPage(title, startTime, endTime, typeId, place)));
      }
    }

    // // picker mode ----------------------------------------------------------------------------------
    CupertinoDatePickerMode _mode() {
      if (_allDay)
        return CupertinoDatePickerMode.date;
      else
        return CupertinoDatePickerMode.dateAndTime;
    }

    void _datePicker(contex, isStart) {
      DateTime _dateTime;
      DateTime _minimumDate;

      if (isStart) {
        _dateTime = _startDateTime;
        _minimumDate = DateTime.now();
      } else {
        _dateTime = _startDateTime.add(Duration(hours: 1));
        _minimumDate = DateTime.now().add(Duration(minutes: 1));
      }

      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                    child: Text('確定', style: TextStyle(color: _color)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              Container(
                height: _sizing.height(28),
                child: CupertinoDatePicker(
                  mode: _mode(),
                  minimumDate: (DateTime(
                      _minimumDate.year,
                      _minimumDate.month,
                      _minimumDate.day,
                      _minimumDate.hour,
                      _minimumDate.minute)),
                  initialDateTime: _dateTime,
                  onDateTimeChanged: (value) => setState(() {
                    if (isStart) {
                      _startDateTime = value;
                      _endDateTime = value.add(Duration(hours: 1));
                    } else
                      _endDateTime = value;
                  }),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // createScheduleList ------------------------------------------------------------------------------
    Widget createScheduleList = ListView(
      children: [
        // text field ----------------------------------------------------------------------------- title
        Padding(
          padding: EdgeInsets.fromLTRB(
              _paddingLR, _sizing.height(3), _paddingLR, _sizing.height(2)),
          child: TextField(
            style: TextStyle(fontSize: _h1Size),
            decoration: InputDecoration(
                hintText: '標題',
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 0.5)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: _color))),
            cursorColor: _color,
            controller: _titleController,
            onSubmitted: (_) => FocusScope.of(context)
                .requestFocus(FocusNode()), //按enter傳回空的focus
          ),
        ),

        //  text ---------------------------------------------------------------------------------- time
        Padding(
          padding: EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 6,
                      child: Text('整天', style: TextStyle(fontSize: _pSize))),
                  Expanded(
                      flex: 1,
                      child: Align(
                        child: CupertinoSwitch(
                          activeColor: _color,
                          value: _allDay,
                          onChanged: (bool value) =>
                              setState(() => _allDay = value),
                        ),
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 開始-------------------------------------------------------
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
                    child: Text(
                      '開始',
                      style: TextStyle(fontSize: _pSize),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _startView,
                      style: TextStyle(
                          fontSize: _timeSize,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () => _datePicker(context, true),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // 結束 ------------------------------------------------------
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(_paddingLR, 0, _paddingLR, 0),
                    child: Text(
                      '結束',
                      style: TextStyle(fontSize: _pSize),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      _endView,
                      style: TextStyle(
                          fontSize: _timeSize,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ButtonStyle(alignment: Alignment.centerRight),
                    onPressed: () => _datePicker(context, false),
                  ),
                ],
              )
            ],
          ),
        ),

        // 分隔線
        Divider(
          height: _sizing.height(2),
          indent: _paddingLR,
          endIndent: _paddingLR,
          color: Colors.grey,
          thickness: 0.5,
        ),

        // dropdown buttn ------------------------------------------------------------------------- type
        Padding(
          padding: EdgeInsets.fromLTRB(
              _listPaddingLR, _sizing.height(1), _listPaddingLR, 0),
          child: Container(
            height: _listItemHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/type.png',
                    height: _sizing.height(5),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
                  child: DropdownButton(
                    itemHeight: _sizing.height(10),
                    hint: Text('類別',
                        style:
                            TextStyle(fontSize: _h2Size, color: Colors.grey)),
                    iconEnabledColor: Colors.grey,
                    underline: Container(),
                    focusColor: _color,
                    value: _type,
                    items: [
                      DropdownMenuItem(
                          child:
                              Text('讀書', style: TextStyle(fontSize: _h2Size)),
                          value: 1),
                      DropdownMenuItem(
                          child:
                              Text('工作', style: TextStyle(fontSize: _h2Size)),
                          value: 2),
                      DropdownMenuItem(
                          child:
                              Text('會議', style: TextStyle(fontSize: _h2Size)),
                          value: 3),
                      DropdownMenuItem(
                          child:
                              Text('休閒', style: TextStyle(fontSize: _h2Size)),
                          value: 4),
                      DropdownMenuItem(
                          child:
                              Text('社團', style: TextStyle(fontSize: _h2Size)),
                          value: 5),
                      DropdownMenuItem(
                          child:
                              Text('吃飯', style: TextStyle(fontSize: _h2Size)),
                          value: 6),
                      DropdownMenuItem(
                          child:
                              Text('班級', style: TextStyle(fontSize: _h2Size)),
                          value: 7),
                      DropdownMenuItem(
                          child:
                              Text('個人', style: TextStyle(fontSize: _h2Size)),
                          value: 8),
                    ],
                    onChanged: (int value) {
                      setState(() => _type = value);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      height: _sizing.height(2.5),
                      child: CircleAvatar(
                        radius: _sizing.height(2.5),
                        backgroundColor: getTypeColor(_type),
                      )),
                )
              ],
            ),
          ),
        ),

        // text field ----------------------------------------------------------------------------- location
        Padding(
          padding: EdgeInsets.fromLTRB(_listPaddingLR, 0, _listPaddingLR, 0),
          child: Container(
            height: _listItemHeight,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/location.png',
                    height: _iconSize,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 8,
                  child: TextField(
                    controller: _locationController,
                    style: TextStyle(fontSize: _h2Size),
                    decoration: InputDecoration(
                      hintText: '地點',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: _color)),
                    ),
                    cursorColor: _color,
                    onSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text('新增行程', style: TextStyle(fontSize: _appBarSize)),
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
      body: GestureDetector(
        // 點擊空白處釋放焦點
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Container(
          color: Colors.white,
          child: SafeArea(
            bottom: false,
            child: Center(child: createScheduleList),
          ),
        ),
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
                        width: _bottomIconWidth,
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
                      width: _bottomIconWidth,
                    ),
                    fillColor: _color,
                    onPressed: () async {
                      await _submit();
                    },
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class InviteFriendPage extends StatefulWidget {
  String groupName;
  String scheduleStart;
  String scheduleEnd;
  int type;
  String place;
  InviteFriendPage(this.groupName, this.scheduleStart, this.scheduleEnd,
      this.type, this.place);

  @override
  _InviteFriendWidget createState() => new _InviteFriendWidget(
      groupName, scheduleStart, scheduleEnd, type, place);
}

class _InviteFriendWidget extends State<InviteFriendPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    _friendNameControlloer();
    await _friendListRequest();
    await _bestFriendListRequest();
  }

  String groupName;
  String scheduleStart;
  String scheduleEnd;
  int type;
  String place;
  _InviteFriendWidget(this.groupName, this.scheduleStart, this.scheduleEnd,
      this.type, this.place);

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
    FriendListModel _request = await FriendList(uid: uid).getData();

    setState(() {
      _friendListModel = _request;

      for (int i = 0; i < _friendListModel.friend.length; i++) {
        _friendCheck[_friendListModel.friend[i].friendId] = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listTop = _sizing.height(3);
    double _listLR = _sizing.height(1);
    double _listPaddingH = _sizing.width(6);
    double _textL = _sizing.height(3);
    double _textBT = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);
    double _iconWidth = _sizing.width(5);
    double _leadingL = _sizing.height(2);
    double _textFied = _sizing.height(4.5);

    double _appBarSize = _sizing.width(5.2);
    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _borderRadius = _sizing.height(1);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _bule = Color(0xff7AAAD8);
    Color _textFiedBorder = Color(0xff070707);

    Widget friendListWidget;

    GetImage _getImage = GetImage(context);

    _submit() async {
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

      var submitWidget;
      _submitWidgetfunc() async {
        return CreateGroup(
            uid: uid,
            groupName: groupName,
            scheduleStart: scheduleStart,
            scheduleEnd: scheduleEnd,
            type: type,
            place: place,
            friend: friend);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    Widget search = Container(
      margin: EdgeInsets.only(right: _textBT, left: _listLR),
      child: Row(
        children: [
          IconButton(
            icon: Image.asset(
              'assets/images/search.png',
              width: _iconWidth,
            ),
            onPressed: () {},
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: _listLR),
              height: _textFied,
              child: TextField(
                style: TextStyle(fontSize: _titleSize),
                decoration: InputDecoration(
                    hintText: '輸入好友名稱搜尋',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: _listLR, vertical: _listLR),
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
                onChanged: (text) {
                  setState(() {
                    _searchText = text;
                  });
                },
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
              child: _getImage.friend(friends.photo),
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
              title: Text('邀請好友', style: TextStyle(fontSize: _appBarSize)),
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
            body: GestureDetector(
              // 點擊空白處釋放焦點
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Container(
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: _listTop),
                  child: Column(
                    children: [
                      search,
                      checkAll,
                      Expanded(child: friendListWidget),
                    ],
                  ),
                ),
              ),
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
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('邀請好友', style: TextStyle(fontSize: _appBarSize)),
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
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSearchBestFriendList(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    GetImage _getImage = GetImage(context);

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
                print(_bestFriendCheck);
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

    double _listPaddingH = _sizing.width(6);

    double _pSize = _sizing.height(2.3);

    GetImage _getImage = GetImage(context);

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
