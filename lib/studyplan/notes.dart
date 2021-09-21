import 'package:My_Day_app/studyplan/1%20copy%202.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'notes_add.dart';
import 'dart:ui';
import 'learn.dart';


class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF86D67),
              title: Text('筆記', style: TextStyle(fontSize: 20)),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotesAddPage()));
                  },
                ),
              ],
            ),
            body: 
            // SingleChildScrollView(
            //   child: Column(children: [
                // Home(),
                ExamplePage(),
              ),
            ));
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
    for (int i = 0; i <1; i++) {
      mList.add(i);
      expandStateList.add(ExpandState(i, false));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        children: [
                          Text.rich(TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                child: new Image.asset(
                                  "assets/images/search.png",
                                  width: 20,
                                ),
                              ),
                              TextSpan(
                                  text: 'xxxxxx',
                                  style: TextStyle(
                                    fontSize: 20,
                                  )),
                            ],
                          )),
                        ],
                      ));
                },
                body: Container(
                  margin: EdgeInsets.only(top: 10, left: 20, right: 15),
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
                          '國文 1~3 課',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.menu,
                          color: Color(0xffE3E3E3),
                        )
                      ],
                    ),
                  ),
                )),
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
  List<String> _list = ["Apple", "Ball", "Cat", "Dog", "Elephant"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: ReorderableListView(
          children: _list
            .map((item) => ListTile(
                  key: Key("${item}"),
                  title: Text("${item}"),
                  trailing: Icon(Icons.menu),
                ))
            .toList(),
        onReorder: (int start, int current) {
          // dragging from top to bottom
          if (start < current) {
            int end = current - 1;
            String startItem = _list[start];
            int i = 0;
            int local = start;
            do {
              _list[local] = _list[++local];
              i++;
            } while (i < end - start);
            _list[end] = startItem;
          }
          // dragging from bottom to top
          else if (start > current) {
            String startItem = _list[start];
            for (int i = start; i > current; i--) {
              _list[i] = _list[i - 1];
            }
            _list[current] = startItem;
          }
          setState(() {});
        },
      ),
    ));
  }
}
