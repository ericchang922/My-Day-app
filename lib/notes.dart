import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'notes_add.dart';
import 'dart:ui';
import 'learn.dart';

void main() {
  runApp(App());
}

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
        home: Scaffold(
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
            body: SingleChildScrollView(
              child: Column(children: [
                Home(),
                ExamplePage(),
              ]),
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
                  child: FlatButton(
                    height: 40,
                    minWidth: double.infinity,
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
                ),
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
    // Draggable/LongPressDraggable 創建一個 可拖動的 源
    return LayoutBuilder(
      builder: (context, constraint) {
        return Draggable(
          // data 指定 拖動的 綁定數據
          data: index,
          // child 指定 源 顯示ui
          // DragTarget 創建一個 拖動目標 來完成 拖動
          child: DragTarget<int>(
            builder: (context, candidate, rejects) {
              return Container(
                margin: EdgeInsets.only(right: 10, left: 20, top: 10),
                child: FlatButton(
                  height: 40,
                  minWidth: double.infinity,
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
                      Icon(
                        Icons.menu,
                        color: Color(0xffE3E3E3),
                      )
                    ],
                  ),
                ),
              );
            },
            onLeave: (data) {
              // 當 拖動源 離開當前 拖動目標時 回調
              debugPrint("onLeave $data -> $index");
            },
            onWillAccept: (data) {
              // 當源被 拖動到此 覆蓋 當前 拖動目標時 回調
              //
              // 如果返回 true 將 接受 拖動 否則 拒絕拖動
              debugPrint("onWillAccept $data -> $index");
              return _items != null && data >= 0 && data < _items.length;
            },
            onAccept: (data) {
              debugPrint("onAccept $data -> $index");
              // onWillAccept 返回 true 且 在此拖動目標上 鬆開手指時 回調
              //
              // 回調完成 後 通知 Draggable.onDragCompleted
              setState(() {
                if (data < index) {
                  final tmp = _items[data];
                  for (var i = data; i < index; i++) {
                    _items[i] = _items[i + 1];
                  }
                  _items[index] = tmp;
                } else {
                  final tmp = _items[data];
                  for (var i = data; i > index; i--) {
                    _items[i] = _items[i - 1];
                  }
                  _items[index] = tmp;
                }
              });
            },
          ),
          // childWhenDragging 指定了被拖動後 源如何顯示 如果爲null 顯示 child
          childWhenDragging: SizedBox(
            child: Card(
              child: ListTile(
                title: Text(name, style: TextStyle(color: theme.accentColor)),
              ),
            ),
          ),
          // feedback 指定了 源被 拖動走時 跟隨手指移動的 顯示ui
          feedback: SizedBox(
            width: constraint.maxWidth - 4,
            height: 64,
            child: Card(
              child: ListTile(
                title: Text(name),
              ),
            ),
          ),
        );
      },
    );
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
