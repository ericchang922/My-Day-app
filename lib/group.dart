import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';

import 'groupAdd.dart';
import 'groupJoin.dart';
import 'learn.dart';

// class GroupPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: GroupPageWidget(),
//       routes: <String, WidgetBuilder>{
//         '/home': (BuildContext context) => new HomePageWidget(),
//         '/group' : (BuildContext context) => new GroupPageWidget(),
//         '/learn' : (BuildContext context) => new LearnPage(),
//       },
//     );
//   }
// }

// enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class GroupPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('群組', style: TextStyle(fontSize: 22)),
          actions: [
            PopupMenuButton<int>(
              offset: Offset(50, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.add),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text("建立群組")),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem<int>(value: 1, child: Text("加入群組")),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ],
        ),
        body: _GroupPage(),
        // bottomNavigationBar: Container(
        //     child: Row(children: <Widget>[
        //   Expanded(
        //     // ignore: deprecated_member_use
        //     child: FlatButton(
        //       height: 50,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(0)),
        //       child: Text(
        //         '首頁',
        //         style: TextStyle(fontSize: 20),
        //       ),
        //       color: Color(0xffF86D67),
        //       textColor: Colors.white,
        //       onPressed: () {
        //         Navigator.pushReplacementNamed(context, '/home');
        //       },
        //     ),
        //   ),
        //   Expanded(
        //     // ignore: deprecated_member_use
        //     child: FlatButton(
        //       height: 50,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(0)),
        //       child: Text(
        //         '群組',
        //         style: TextStyle(
        //           fontSize: 20,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       ),
        //       color: Color(0xffF86D67),
        //       textColor: Color(0xffF6CA07),
        //       onPressed: () {},
        //     ),
        //   ),
        //   Expanded(
        //     // ignore: deprecated_member_use
        //     child: FlatButton(
        //       height: 50,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(0)),
        //       child: Text(
        //         '玩聚',
        //         style: TextStyle(fontSize: 20),
        //       ),
        //       color: Color(0xffF86D67),
        //       textColor: Colors.white,
        //       onPressed: () {},
        //     ),
        //   ),
        //   Expanded(
        //     // ignore: deprecated_member_use
        //     child: FlatButton(
        //       height: 50,
        //       shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(0)),
        //       child: Text(
        //         '學習',
        //         style: TextStyle(fontSize: 20),
        //       ),
        //       color: Color(0xffF86D67),
        //       textColor: Colors.white,
        //       onPressed: () {
        //         Navigator.push(context,
        //             MaterialPageRoute(builder: (context) => LearnPage()));
        //       },
        //     ),
        //   ),
        // ]))
        );
  }
}

void SelectedItem(BuildContext context, item) {
  switch (item) {
    case 0:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => GroupAddWidget()));
      break;
    case 1:
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => GroupJoinWidget()));
      break;
  }
}

class _GroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const items = <String>[
      '學生會 (20)',
      '班群 (50)',
      '午餐群 (5)',
    ];
    const color = <int>[0xffFFA800, 0xffB6EB3A, 0xffF78787];
    return ListView.separated(
      itemCount: items.length,
      itemBuilder: (context, index) => Container(
        margin: EdgeInsets.only(
          top: 5,
          left: 10,
        ),
        child: ListTile(
            title: Text(
              items[index],
              style: TextStyle(fontSize: 20),
            ),
            leading: Container(
              margin: EdgeInsets.only(
                right: 5,
              ),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Color(color[index]),
              ),
            )),
      ),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
