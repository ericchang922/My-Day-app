// import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';

class BestFriendAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BestFriendAddPageWidget(),
     
    );
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class BestFriendAddPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title:Text('新增摯友',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ), 
        
      ), 
      body: ExamplePage(),
    );
  }
}
class ExamplePage extends StatefulWidget {
  ExamplePage({Key key}) : super(key: key);
  @override
  _ExamplePageState createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  final _items = ["國文 1~3 課"];
  get child => null;
  bool viewVisible = true;

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    final theme = Theme.of(context);
    final name = _items[index];
    return Column(
      children: <Widget>[ 
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: viewVisible,
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15, left: 35,top:10),
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
                      TextSpan(text:_items[index], style: TextStyle(fontSize: 20)),
                    ],
                  )),
                  FlatButton(
                    height: 40,
                    minWidth: 15,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      '新增',
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Color(0xffF86D67),
                    textColor: Colors.white,
                    onPressed: hideWidget,
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              color: Color(0xffE3E3E3),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
        ]))]);
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



