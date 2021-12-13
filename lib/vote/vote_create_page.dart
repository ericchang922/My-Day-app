import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:date_format/date_format.dart';

import 'package:My_Day_app/vote/vote_setting_page.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/sizing.dart';

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

  bool _isNotCreate = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    Sizing _sizing = Sizing(context);

    double _textFied = _sizing.height(4.5);
    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);
    double _bottomIconWidth = _sizing.width(5);

    double _pSize = _sizing.height(2.3);
    double _titleSize = _sizing.width(6);
    double _appBarSize = _sizing.width(5.2);

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
          height: _sizing.height(40),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定', style: TextStyle(color: _color)),
                      onPressed: () => Navigator.of(context).pop()),
                ),
              ),
              Container(
                height: _sizing.height(28),
                child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.dateAndTime,
                    initialDateTime: _dateTime,
                    onDateTimeChanged: (value) {
                      setState(() {
                        _dateTime = value;
                        _voteDateValues[index] = _dateFormat(_dateTime);
                        _voteDateFormat[index] = _dateTime;
                        int count = _voteCount();
                        if (count == 0) {
                          _voteDateValues.add("");
                          _voteDateFormat.add("");
                        }
                      });
                    }),
              ),
            ],
          ),
        ),
      );
    }

    Widget createVoteItem = ListView.builder(
      padding: EdgeInsets.only(bottom: _sizing.height(3)),
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
                    padding: EdgeInsets.all(_sizing.height(1)),
                    margin: EdgeInsets.only(top: _sizing.height(3)),
                    child: Text('${index + 1}.',
                        style: TextStyle(fontSize: _appBarSize))),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: _sizing.height(3)),
                    child: TextField(
                      controller: TextEditingController.fromValue(
                          TextEditingValue(
                              text: _voteValues[index],
                              selection: TextSelection.fromPosition(
                                  TextPosition(
                                      affinity: TextAffinity.downstream,
                                      offset: _voteValues[index].length)))),
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: _appBarSize),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_sizing.width(2)),
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
                      },
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: _hintGray, height: 1)
          ],
        );
      },
    );

    Widget createVote = ListView(
      padding: EdgeInsets.only(
          top: _sizing.height(3),
          right: _sizing.height(5),
          left: _sizing.height(5)),
      children: [
        TextField(
          controller: _voteTitleController,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: _titleSize),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(_sizing.width(2)),
            hintText: '輸入投票問題',
            hintStyle: TextStyle(color: _hintGray, fontSize: _titleSize),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
            ),
          ),
        ),
        createVoteItem
      ],
    );

    Widget createDateVoteItme = ListView.builder(
      padding: EdgeInsets.only(bottom: _sizing.height(3)),
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
                    padding: EdgeInsets.all(_sizing.height(1)),
                    margin: EdgeInsets.only(top: _sizing.height(3)),
                    child: Text('${index + 1}.',
                        style: TextStyle(fontSize: _appBarSize))),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(top: _sizing.height(3)),
                    child: TextField(
                      focusNode: _contentFocusNode,
                      controller: _voteDateItemController,
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: _appBarSize),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(_sizing.width(2)),
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
            Divider(color: _hintGray, height: 1)
          ],
        );
      },
    );

    Widget createDateVote = ListView(
      padding: EdgeInsets.only(
          top: _sizing.height(3),
          right: _sizing.height(5),
          left: _sizing.height(5)),
      children: [
        TextField(
          controller: _voteDateTitleController,
          cursorColor: Colors.black,
          style: TextStyle(fontSize: _titleSize),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(_sizing.width(2)),
            hintText: '輸入投票問題',
            hintStyle: TextStyle(color: _hintGray, fontSize: _titleSize),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: _hintGray),
            ),
          ),
        ),
        createDateVoteItme
      ],
    );

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
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
                            color: _yellow,
                            width: 0,
                            style: BorderStyle.solid)),
                    gradient: LinearGradient(colors: [_yellow, _yellow])),
                labelColor: Colors.white,
                unselectedLabelColor: _hintGray,
                indicatorPadding: EdgeInsets.all(0.0),
                indicatorWeight: _sizing.width(1),
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
            body: GestureDetector(
              // 點擊空白處釋放焦點
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: TabBarView(
                controller: _tabController,
                children: <Widget>[
                  Container(color: Colors.white, child: createVote),
                  Container(color: Colors.white, child: createDateVote)
                ],
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
                            String _alertTitle = '新增投票失敗';
                            String _title;
                            int _optionTypeId = _tabController.index;
                            _voteItems = [];
                            _voteItemsName = [];
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
                                  _voteItemsName
                                      .add(_voteDateFormat[i].toString());
                                }
                              }
                              _title = _voteDateTitleController.text;
                            }
                            for (int i = 0; i < _voteItemsName.length; i++) {
                              _voteItems.add({
                                "voteItemNum": i + 1,
                                "voteItemName": _voteItemsName[i]
                              });
                            }
                            if (_title == '' || _title == null) {
                              await alert(context, _alertTitle, '請輸入投票問題');
                              _isNotCreate = true;
                            }

                            if (_voteItemsName.length < 2) {
                              await alert(context, _alertTitle, '請至少新增兩個投票項目');
                              _isNotCreate = true;
                            }
                            print(_title);
                            print(_voteItems);
                            if (_isNotCreate) {
                              _isNotCreate = false;
                            } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => VoteSettingPage(
                                      groupNum,
                                      _optionTypeId + 1,
                                      _title,
                                      _voteItems)));
                            }
                          }),
                    )),
                  ]),
                ),
              ),
            )),
      ),
    );
  }
}
