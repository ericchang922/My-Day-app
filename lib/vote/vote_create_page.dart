import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/vote/vote_setting_page.dart';

import 'package:date_format/date_format.dart';

class VoteCreatePage extends StatefulWidget {
  int groupNum;
  VoteCreatePage(this.groupNum);

  @override
  _VoteCreateWidget createState() => new _VoteCreateWidget(groupNum);
}

class _VoteCreateWidget extends State<VoteCreatePage>
    with SingleTickerProviderStateMixin {
  int groupNum;
  _VoteCreateWidget(this.groupNum);

  TabController _tabController;

  final _voteTitleController = TextEditingController();
  final _voteDateTitleController = TextEditingController();

  List _voteValues = List.generate(2, (index) => "");
  List _voteDateValues = List.generate(2, (index) => "");
  List _voteDateFormat = List.generate(2, (index) => "");
  List<Map<String, dynamic>> _voteItems = [];
  List<String> _voteItemsName = [];

  String _value = '';
  String _dateValue = '';

  TextEditingController get _voteItemController =>
      TextEditingController(text: _value);

  TextEditingController get _voteDateItemController =>
      TextEditingController(text: _dateValue);

  FocusNode _contentFocusNode = FocusNode();

  bool _isEnabled;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => {
          if (!_tabController.indexIsChanging)
            {_isEnabled = false, _buttonIsOnpressed()}
        });
    _buttonIsOnpressed();
  }

  _buttonIsOnpressed() {
    int count = 0;
    if (_tabController.index == 0) {
      for (int i = 0; i < _voteValues.length; i++) {
        if (_voteValues[i] != "") {
          count++;
        }
      }
      if (count < 2 || _voteTitleController.text.isEmpty) {
        setState(() {
          _isEnabled = false;
        });
      } else {
        setState(() {
          _isEnabled = true;
        });
      }
    }
    if (_tabController.index == 1) {
      for (int i = 0; i < _voteDateValues.length; i++) {
        if (_voteDateValues[i] != "") {
          count++;
        }
      }
      if (count < 2 || _voteDateTitleController.text.isEmpty) {
        setState(() {
          _isEnabled = false;
        });
      } else {
        setState(() {
          _isEnabled = true;
        });
      }
    }
    return count;
  }

  _voteCount() {
    int count = 0;
    if (_tabController.index == 0) {
      for (int i = 0; i < _voteValues.length; i++) {
        if (_voteValues[i] == "") {
          count++;
        }
      }
    }
    if (_tabController.index == 1) {
      for (int i = 0; i < _voteDateValues.length; i++) {
        if (_voteDateValues[i] == "") {
          count++;
        }
      }
    }
    return count;
  }

  String _dateFormat(dateTime) {
    String dateString = formatDate(
        DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
            dateTime.minute),
        [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
    return dateString;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _height = size.height;

    double _textFied = _height * 0.045;
    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;

    double _pSize = _height * 0.023;
    double _titleSize = _width * 0.06;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _yellow = Color(0xffEFB208);
    Color _hintGray = Color(0xffCCCCCC);

    void _datePicker(contex, index) {
      DateTime _dateTime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 8, 0);
      if (_voteDateValues[index] != "") {
        _dateTime = _voteDateFormat[index];
      }
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: _height * 0.35,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: _height * 0.065,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定', style: TextStyle(color: _color)),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          _voteDateValues[index] = _dateFormat(_dateTime);
                          _voteDateFormat[index] = _dateTime;
                          int count = _voteCount();
                          if (count == 0) {
                            _voteDateValues.add("");
                            _voteDateFormat.add("");
                          }
                        });
                        _buttonIsOnpressed();
                      }),
                ),
              ),
              Container(
                height: _height * 0.28,
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: _dateTime,
                    onDateTimeChanged: (value) {
                      setState(() {
                        _dateTime = value;
                      });
                    }),
              ),
            ],
          ),
        ),
      );
    }

    Widget createVoteItem = ListView.builder(
      padding: EdgeInsets.only(bottom: _height * 0.03),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _voteValues.length,
      itemBuilder: (BuildContext context, int index) {
        _value = _voteValues[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(_height * 0.01),
                    margin: EdgeInsets.only(top: _height * 0.03),
                    child: Text('${index + 1}.',
                        style: TextStyle(fontSize: _appBarSize))),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: _height * 0.03),
                    child: TextField(
                      controller: _voteItemController,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: _appBarSize),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_width * 0.02),
                        hintText: '輸入選項',
                        hintStyle:
                            TextStyle(color: _hintGray, fontSize: _appBarSize),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (text) {
                        setState(() {
                          _voteValues[index] = text;
                          int count = _voteCount();
                          if (count == 0) _voteValues.add("");
                        });
                        _buttonIsOnpressed();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: _hintGray)
          ],
        );
      },
    );

    Widget createVote = ListView(
      padding: EdgeInsets.only(
          top: _height * 0.03, right: _height * 0.05, left: _height * 0.05),
      children: [
        TextField(
          controller: _voteTitleController,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: _titleSize),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(_width * 0.02),
            hintText: '輸入投票問題',
            hintStyle: TextStyle(color: _hintGray, fontSize: _titleSize),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
              //  when the TextFormField in focused
            ),
          ),
          onChanged: (text) {
            _buttonIsOnpressed();
          },
        ),
        createVoteItem
      ],
    );

    Widget createDateVoteItme = ListView.builder(
      padding: EdgeInsets.only(bottom: _height * 0.03),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _voteDateValues.length,
      itemBuilder: (BuildContext context, int index) {
        _dateValue = _voteDateValues[index];
        return Column(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(_height * 0.01),
                    margin: EdgeInsets.only(top: _height * 0.03),
                    child: Text('${index + 1}.',
                        style: TextStyle(fontSize: _appBarSize))),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: _height * 0.03),
                    child: TextField(
                      focusNode: _contentFocusNode,
                      controller: _voteDateItemController,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: _appBarSize),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_width * 0.02),
                        hintText: '選擇日期',
                        hintStyle:
                            TextStyle(color: _hintGray, fontSize: _appBarSize),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onTap: () {
                        _contentFocusNode.unfocus();
                        _datePicker(context, index);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: _hintGray)
          ],
        );
      },
    );

    Widget createDateVote = ListView(
      padding: EdgeInsets.only(
          top: _height * 0.03, right: _height * 0.05, left: _height * 0.05),
      children: [
        TextField(
          controller: _voteDateTitleController,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: _titleSize),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(_width * 0.02),
            hintText: '輸入投票問題',
            hintStyle: TextStyle(color: _hintGray, fontSize: _titleSize),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
              //  when the TextFormField in focused
            ),
          ),
          onChanged: (text) {
            _buttonIsOnpressed();
          },
        ),
        createDateVoteItme
      ],
    );

    _onPressed() {
      var _onPressed;
      if (_isEnabled == true) {
        _onPressed = () {
          String _title;
          int _optionTypeId = _tabController.index;
          setState(() {
            // ignore: deprecated_member_use
            _voteItems = new List();
            // ignore: deprecated_member_use
            _voteItemsName = new List();
            if (_optionTypeId == 0) {
              for (int i = 0; i < _voteValues.length; i++) {
                if (_voteValues[i] != "") {
                  _voteItemsName.add(_voteValues[i]);
                }
              }
              _title = _voteTitleController.text;
            } else {
              for (int i = 0; i < _voteDateFormat.length; i++) {
                if (_voteDateFormat[i] != "") {
                  _voteItemsName.add(_voteDateFormat[i].toString());
                }
              }
              _title = _voteDateTitleController.text;
            }
            for (int i = 0; i < _voteItemsName.length; i++) {
              _voteItems.add(
                  {"voteItemNum": i + 1, "voteItemName": _voteItemsName[i]});
            }
            print(_title);
            print(_voteItems);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VoteSettingPage(
                    groupNum, _optionTypeId + 1, _title, _voteItems)));
          });
        };
      }
      return _onPressed;
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _color,
          title: Text('建立投票', style: TextStyle(fontSize: _appBarSize)),
          leading: Container(
            margin: EdgeInsets.only(left: _leadingL),
            child: GestureDetector(
              child: Icon(Icons.chevron_left),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicator: ShapeDecoration(
                shape: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: _yellow, width: 0, style: BorderStyle.solid)),
                gradient: LinearGradient(colors: [_yellow, _yellow])),
            labelColor: Colors.white,
            unselectedLabelColor: _hintGray,
            indicatorPadding: EdgeInsets.all(0.0),
            indicatorWeight: _width * 0.01,
            labelPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            tabs: <Widget>[
              Container(
                height: _textFied,
                alignment: Alignment.center,
                color: _color,
                child: Text("選項", style: TextStyle(fontSize: _pSize)),
              ),
              Container(
                height: _textFied,
                alignment: Alignment.center,
                color: _color,
                child: Text("日期", style: TextStyle(fontSize: _pSize)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(color: Colors.white, child: createVote),
            Container(color: Colors.white, child: createDateVote)
          ],
        ),
        bottomNavigationBar: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: _bottomHeight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Image.asset(
                'assets/images/cancel.png',
                width: _bottomIconWidth,
              ),
              color: _light,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
              // ignore: deprecated_member_use
              child: Builder(builder: (context) {
            // ignore: deprecated_member_use
            return FlatButton(
                disabledColor: _hintGray,
                height: _bottomHeight,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0)),
                child: Image.asset(
                  'assets/images/confirm.png',
                  width: _bottomIconWidth,
                ),
                color: _color,
                textColor: Colors.white,
                onPressed: _onPressed());
          }))
        ]));
  }
}
