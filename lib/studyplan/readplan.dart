
import 'package:My_Day_app/studyplan/readplan_add.dart';
import 'package:My_Day_app/studyplan/readplan_content.dart';
import 'package:My_Day_app/studyplan/readplan_content_over.dart';
import 'package:flutter/material.dart';

import 'readplan_content.dart';

class ReadPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ReadPlanPage(),
    ));
  }
}

class ReadPlanPage extends StatefulWidget {
  ReadPlanPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReadPlanPage createState() => _ReadPlanPage();
}

class _ReadPlanPage extends State<ReadPlanPage> {
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        
        length: 3,
        child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF86D67),
            title: Text('讀書計畫', style: TextStyle(fontSize: 20)),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReadPlanAddPage()));
                },
              ),
            ],
            bottom: TabBar(
              
              indicatorWeight:5,
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xffE3E3E3),
              indicatorColor: Color(0xffEFB208),
              tabs: <Widget>[
                Tab(text: '未結束'),
                Tab(text: '已結束'),
                Tab(text: '已共享'),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Column(children: [
                NotOverPersonal(),
                Home(),
              ]),
              Column(children: [
                OverPersonal(),
                Home(),
              ]),
              FriendsPrivacySettingsPage(),
            ],
          ),
    )));
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<int> mList = new List();
  List<ExpandState> expandStateList = new List();
  void initState() {
    for (int i = 0; i < 3; i++) {
      mList.add(i);
      expandStateList.add(ExpandState(i, false));
    }
  }

  @override
  Widget build(BuildContext context) {
    const items = <String>[
      '專題','讀書會','學生會',
    ];
    return Container(
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          elevation: 0,
          expansionCallback: (index, bool) {
            //回调
            setState(() {
              expandStateList[index].isOpen = !expandStateList[index].isOpen;
            });
          },
          children: mList.map((index) {
            return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  Divider(
                    color: Color(0xffcccccc),
                    height: 1,
                  );
                  return Container(
                      margin: EdgeInsets.only(right: 15, left: 35, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            items[index],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ));
                },
                body: ExamplePage(),
                isExpanded: expandStateList[index].isOpen);
          }).toList(),
        ),
      ),
    );
  }
}

class ExpandState {
  var isOpen;
  var index;
  ExpandState(this.index, this.isOpen);
}

class ExamplePage extends StatefulWidget {
  ExamplePage({Key key}) : super(key: key);
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _items = ["國文 1~3 課", "國文 4~6 課", "國文 7~9 課", "國文 10~12 課"];
  Widget _buildItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final name = _items[index];
    return Container(
      margin: EdgeInsets.only(right: 10, left: 20, top: 10),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: TextButton(
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>(_items.length);
    for (var i = 0; i < _items.length; i++) {
      children[i] = _buildItem(context, i);
    }
    return ListView(shrinkWrap: true, children: children);
    // bottomNavigationBar:
  }
}
class NotOverPersonal extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top:10),
          child: SizedBox(
              height: 40,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Text(
                  '個人',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff7AAAD8),
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ))),
        Container(
          margin: EdgeInsets.only(left: 20, right: 10.0, top: 10.0),
          // ignore: deprecated_member_use
          child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => ReadPlanContentPage()));
            },
            child: Row(
              children: <Widget>[
                Text(
                  '10/8',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Column(children: <Widget>[
                  Text(
                    '期末考',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '8:00~12:00',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ]),
                Spacer(flex: 3),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ],
            ),
          )),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
        Container(
          margin: EdgeInsets.only(right: 300, top: 10, bottom: 10),
          child: Text(
            '群組',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff7AAAD8),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
class OverPersonal extends StatelessWidget {
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top:10),
          child: SizedBox(
              height: 40,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
            onPressed: () {},
            child: Row(
              children: <Widget>[
                Text(
                  '個人',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff7AAAD8),
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ))),
        Container(
          margin: EdgeInsets.only(left: 20, right: 10.0, top: 10.0),
          // ignore: deprecated_member_use
          child: SizedBox(
              height: 60,
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
            onPressed: () {
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => OverReadPlanContentPage()));
            },
            child: Row(
              children: <Widget>[
                Text(
                  '10/8',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Column(children: <Widget>[
                  Text(
                    '期末考',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    '8:00~12:00',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ]),
                Spacer(flex: 3),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ],
            ),
          )),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              margin: EdgeInsets.only(top: 4.0),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            )),
        Container(
          margin: EdgeInsets.only(right: 300, top: 10, bottom: 10),
          child: Text(
            '群組',
            style: TextStyle(
                fontSize: 20,
                color: Color(0xff7AAAD8),
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class Spacer extends StatelessWidget {
  const Spacer({Key key, this.flex = 1})
      : assert(flex != null),
        assert(flex > 0),
        super(key: key);
  final int flex;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: const SizedBox.shrink(),
    );
  }
}

class FriendsPrivacySettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendsPrivacySettings();
  }
}

class FriendsPrivacySettings extends State {
  get child => null;
  get left => null;
  List<int> mList = new List();
  List<ExpandState> expandStateList = new List();
  void initState() {
    for (int i = 0; i < 3; i++) {
      mList.add(i);
      expandStateList.add(ExpandState(i, false));
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 15, left: 35,top:10),
            child: Row(
              children: <Widget>[
                Text(
                  '10/8',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Spacer(),
                Column(children: <Widget>[
                  Text(
                    '讀書計畫',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    '8:00~12:00',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ]),
                Spacer(flex: 3),
                PopupMenuButton<int>(
                  offset: Offset(-50, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('取消分享',style: TextStyle(fontSize: 20
                              ),
                            ),
                          ])),
                  ],
                ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
        ],
      ),
    ));
  }
}
