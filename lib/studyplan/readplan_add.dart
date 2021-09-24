import 'package:My_Day_app/studyplan/readplan_add_note.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:date_format/date_format.dart';

class ReadPlanAddPage extends StatelessWidget {
  const ReadPlanAddPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ReadPlanAdd();
  }
}

class _ReadPlanAdd extends StatefulWidget {
  _ReadPlanAdd({Key key}) : super(key: key);

  @override
  ReadPlanAdd createState() => ReadPlanAdd();
}

class ReadPlanAdd extends State<_ReadPlanAdd>
    with SingleTickerProviderStateMixin {
  TabController con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    con.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _iconWidth = _width * 0.05;
    return  SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF86D67),
              title: Text('新增讀書計畫', style: TextStyle(fontSize: 20)),
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                ReadPlanAddTitle(),
                ReadPlanAddList(),
                ReadPlanAddListAdd(),
              ]),
            ),
            bottomNavigationBar: Container(
                child: Row(children: <Widget>[
              Expanded(
                // ignore: deprecated_member_use
                child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Color(0xffFFAAA6)
                        ),
                  
                  child: Image.asset(
                    'assets/images/cancel.png',
                    width: _iconWidth,
                  ),
                  
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
              ),
              Expanded(
                // ignore: deprecated_member_use
                child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Color(0xffF86D67)
                        ),
                  
                  child: Image.asset(
                    'assets/images/confirm.png',
                    width: _iconWidth,
                  ),
                  
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
    )]))));
  }
}

class ReadPlanAddTitle extends StatefulWidget {
  @override
  _ReadPlanAddTitle createState() => _ReadPlanAddTitle();
}

class _ReadPlanAddTitle extends State<ReadPlanAddTitle> {
  var _dateTime = DateTime.now(); //当前选中的日期
  TimeOfDay _Time = TimeOfDay.now();
  var now = DateTime.now();
  get child => null; //当前选中的时间
  @override
  Widget build(BuildContext context) {
    String _dateFormat(dateTime) {
        String dateString = formatDate(
            DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
                dateTime.minute),
            [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
        return dateString;
      }

    void _datePicker(context) {
      var screenSize = MediaQuery.of(context).size;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: screenSize.height * 0.35,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: screenSize.height * 0.065,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定',style: TextStyle(color: Color(0xffF86D67))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        setState(() {
                          print(_dateTime);
                        });
                      }),
                ),
              ),
              Container(
                height: screenSize.height * 0.28,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.dateAndTime,
                  initialDateTime: DateTime.now(),
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

  void _timePicker(context) {
      var screenSize = MediaQuery.of(context).size;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: screenSize.height * 0.35,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: screenSize.height * 0.065,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定',style: TextStyle(color: Color(0xffF86D67))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // setState(() {
                        //   print(_dateTime);
                        // });
                      }),
                ),
              ),
              Container(
                height: screenSize.height * 0.28,
                child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(hours: now.hour,minutes: now.minute,seconds: now.second),
                  onTimerDurationChanged: (Duration duration) {},
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(children: <Widget>[
      Container(
          margin: EdgeInsets.only(left: 30, right: 150, bottom: 15, top: 15),
          child: Row(children: [
            Text('標題: ', style: TextStyle(fontSize: 20)),
            Flexible(
                child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 20,
              minLines: 1,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
                  borderSide: BorderSide(
                    //用来配置边框的样式
                    color: Color(0xff707070), //设置边框的颜色
                    width: 2.0, //设置边框的粗细
                  ),
                ),
              ),
            )),
          ])),
      Container(
          margin: EdgeInsets.only(left: 30, right: 110, bottom: 15),
          child: Row(
            children: [
              Container(
                child: Text('日期: ', style: TextStyle(fontSize: 20)),
              ),
              //可以通过在外面包裹一层InkWell来让某组件可以响应用户事件
              SizedBox(
                height: 40,
                width: 135,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xff707070)),
                      borderRadius: BorderRadius.circular(10)),
                  ),
                
                child: InkWell(
                  onTap: () {
                    //调起日期选择器
                    _datePicker(context);
                  },
                  child: Row(
                    children: <Widget>[
                      Text(formatDate(
                          this._dateTime, [yyyy, "-", mm, "-", "dd"])),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
              )
              )],
          )),
      Container(
        margin: EdgeInsets.only(left: 30, bottom: 15, right: 70),
        child: Row(
          children: [
            Text('時間: ', style: TextStyle(fontSize: 20)),
            Flexible(
              child: SizedBox(
                height: 40,
                width: 80,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xff707070)),
                      borderRadius: BorderRadius.circular(10)),
                    ),
                    child: InkWell(
                      onTap: () {
                        //调起时间选择器
                        _timePicker(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${this._Time.format(context)}"),
                        ],
                      ),
            )))),
            Text(' - ', style: TextStyle(fontSize: 20)),
            Flexible(
                child: SizedBox(
                    height: 40,
                    width: 80,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        
                        shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xff707070)),
                          borderRadius: BorderRadius.circular(10)),
                        
                        ),
                    
                    child: InkWell(
                      onTap: () {
                        //调起时间选择器
                         _timePicker(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${this._Time.format(context)}"),
                        ],
                      ),
                    )))
            )],
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 4.0),
        color: Color(0xffE3E3E3),
        constraints: BoxConstraints.expand(height: 1.0),
      ),
    ]);
  }
}

class ReadPlanAddList extends StatefulWidget {
  ReadPlanAddList({Key key}) : super(key: key);

  _ReadPlanAddList createState() => _ReadPlanAddList();
}

class _ReadPlanAddList extends State<ReadPlanAddList> {
  TimeOfDay _Time = TimeOfDay.now();
  var now = DateTime.now();
  var _dateTime = DateTime.now(); //当前选中的时间
  @override
  Widget _buildItem(BuildContext context, int index) {
    //调起时间选择器
    String _dateFormat(dateTime) {
        String dateString = formatDate(
            DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour,
                dateTime.minute),
            [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
        return dateString;
      }
    void _timePicker(context) {
      var screenSize = MediaQuery.of(context).size;
      showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
          height: screenSize.height * 0.35,
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: screenSize.height * 0.065,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CupertinoButton(
                      child: Text('確定',style: TextStyle(color: Color(0xffF86D67))),
                      onPressed: () {
                        Navigator.of(context).pop();
                        // setState(() {
                        //   print(_dateTime);
                        // });
                      }),
                ),
              ),
              Container(
                height: screenSize.height * 0.28,
                child: CupertinoTimerPicker(
                  initialTimerDuration: Duration(hours: now.hour,minutes: now.minute,seconds: now.second),
                  onTimerDurationChanged: (Duration duration) {},
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            margin: EdgeInsets.only(left: 30, right: 50, top: 15),
            child: Row(children: [
              Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Flexible(
                      child: InkWell(
                    onTap: () {
                      //调起时间选择器
                      _timePicker(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text("${this._Time.format(context)}"),
                      ],
                    ),
                  ))),
              Flexible(
                  child: TextField(
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
                    borderSide: BorderSide(
                      //用来配置边框的样式
                      color: Color(0xff707070), //设置边框的颜色
                      width: 2.0, //设置边框的粗细
                    ),
                  ),
                ),
              )),
            ])),
        Container(
            margin: EdgeInsets.only(left: 30, right: 50),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: InkWell(
                    onTap: () {
                      //调起时间选择器
                     _timePicker(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text("${this._Time.format(context)}"),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 40,
                    child:TextButton.icon(
                      icon: Icon(Icons.add, color: Color(0xffF86D67)),
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      ),
                      label: Text(
                        '備註',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () async {
                        bool action = await readplanAddDialog(context);
                      },
                    ),
        )])),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          color: Color(0xffE3E3E3),
          constraints: BoxConstraints.expand(height: 1.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var _items = 1;
    final children = List<Widget>(_items);
    for (var i = 0; i < _items; i++) {
      children[i] = _buildItem(context, i);
    }
    return ListView(shrinkWrap: true, children: children);
    // bottomNavigationBar:
  }
}

// HomePage
class ReadPlanAddListAdd extends StatefulWidget {
  @override
  _ReadPlanAddListAdd createState() => _ReadPlanAddListAdd();
}

// Randomly colored Container
Container createNewContainer() {
  return Container(
    child: ReadPlanAddList(),
  );
}

// _HomePageState
class _ReadPlanAddListAdd extends State<ReadPlanAddListAdd> {
  // Init
  List<Container> containerList = [];

  // Add
  void addContainer() {
    containerList.add(createNewContainer());
  }

  // _childrenList
  List<Widget> _childrenList() {
    return containerList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Column(
            children: _childrenList(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0, right: 230),
          child: TextButton.icon(
            style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
            label: Text('新增欄位', style: TextStyle(fontSize: 18)),
            onPressed: () {
              setState(() {
                addContainer();
              });
            },
            icon: Icon(
              Icons.add,
              color: Color(0xffF86D67),
            ),
          ),
        )
      ],
    );
  }
}
