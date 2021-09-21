import 'package:My_Day_app/studyplan/note_choose.dart';
import 'package:My_Day_app/studyplan/readplan_add_note.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'dart:ui';
import 'package:date_format/date_format.dart';

class ReadPlanEdit extends StatelessWidget {
  const ReadPlanEdit({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return App2();
  }
}

class App2 extends StatefulWidget {
  App2({Key key}) : super(key: key);

  @override
  Notes createState() => Notes();
}

class Notes extends State<App2> with SingleTickerProviderStateMixin {
  // List _page=[Home3(),Home2(),Home4()];
  // int index=0;
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF86D67),
              title: Text('編輯讀書計畫', style: TextStyle(fontSize: 20)),
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Home(),
                TimePickerPage(),
                HomePage(),
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
    )])))));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime _selectedDate = DateTime.now(); //当前选中的日期
  TimeOfDay _selectedTime = TimeOfDay.now();

  get child => null; //当前选中的时间
  @override
  Widget build(BuildContext context) {
    _showDatePicker() {
      //获取异步方法里面的值的第一种方式：then
      showDatePicker(
        //如下四个参数为必填参数
        context: context,
        initialDate: _selectedDate, //选中的日期
        firstDate: DateTime(1980), //日期选择器上可选择的最早日期
        lastDate: DateTime(2100), //日期选择器上可选择的最晚日期
      ).then((selectedValue) {
        setState(() {
          //将选中的值传递出来
          this._selectedDate = selectedValue;
        });
      });
    }

    //调起时间选择器
    _showTimePicker() async {
      // 获取异步方法里面的值的第二种方式：async+await
      //await的作用是等待异步方法showDatePicker执行完毕之后获取返回值
      var result = await showTimePicker(
        context: context,
        initialTime: _selectedTime, //选中的时间
      );
      //将选中的值传递出来
      setState(() {
        this._selectedTime = result;
      });
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
          margin: EdgeInsets.only(left: 30, right: 120, bottom: 15),
          child: Row(
            children: [
              Container(
                child: Text('日期: ', style: TextStyle(fontSize: 20)),
              ),
              //可以通过在外面包裹一层InkWell来让某组件可以响应用户事件
              SizedBox(
                height: 40,
                width: 125,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(side: BorderSide(color: Color(0xff707070)),
                      borderRadius: BorderRadius.circular(10)),
                  ),
            
                child: InkWell(
                  onTap: () {
                    //调起日期选择器
                    _showDatePicker();
                  },
                  child: Row(
                    children: <Widget>[
                      Text(formatDate(
                          this._selectedDate, [yyyy, "-", mm, "-", "dd"])),
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
                        _showTimePicker();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${this._selectedTime.format(context)}"),
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
                        _showTimePicker();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("${this._selectedTime.format(context)}"),
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

class TimePickerPage extends StatefulWidget {
  TimePickerPage({Key key}) : super(key: key);

  _TimePickerPageState createState() => _TimePickerPageState();
}

class _TimePickerPageState extends State<TimePickerPage> {
  TimeOfDay _selectedTime = TimeOfDay.now(); //当前选中的时间
  @override
  Widget _buildItem(BuildContext context, int index) {
    //调起时间选择器
    _showTimePicker() async {
      // 获取异步方法里面的值的第二种方式：async+await
      //await的作用是等待异步方法showDatePicker执行完毕之后获取返回值
      var result = await showTimePicker(
        context: context,
        initialTime: _selectedTime, //选中的时间
      );
      //将选中的值传递出来
      setState(() {
        this._selectedTime = result;
      });
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
                      _showTimePicker();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("${this._selectedTime.format(context)}"),
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
                      _showTimePicker();
                    },
                    child: Row(
                      children: <Widget>[
                        Text("${this._selectedTime.format(context)}"),
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
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () async{
                        bool action = await readplanAddDialog(context);
                      },
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
                      '筆記',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async{
                      Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReadPlanChoose()));
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
    var _items = 3;
    final children = List<Widget>(_items);
    for (var i = 0; i < _items; i++) {
      children[i] = _buildItem(context, i);
    }
    return ListView(shrinkWrap: true, children: children);
    // bottomNavigationBar:
  }
}

// HomePage
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Randomly colored Container
Container createNewContainer() {
  return Container(
    child: TimePickerPage(),
  );
}

// _HomePageState
class _HomePageState extends State<HomePage> {
  // Init
  List<Container> containerList = [ ];

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
          margin: EdgeInsets.only(top: 4.0,right:230),
          child:TextButton.icon(
            style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
            label:Text('新增欄位',style: TextStyle(fontSize: 18)),  
            onPressed: () {
              setState(() {
                addContainer();
              });
            },
           icon:Icon(Icons.add,color: Color(0xffF86D67),),
        ),
        )],
    );
  }
}
