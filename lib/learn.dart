// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'main.dart';

const PrimaryColor = const Color(0xFFF86D67);

// void main() {runApp(MyApp());}

// class LearnPage extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       routes: <String, WidgetBuilder> {
//         '/home': (BuildContext context) => new HomePageWidget(),
//         '/group' : (BuildContext context) => new GroupPageWidget(),
//         '/learn' : (BuildContext context) => new LearnPage(),
//       },
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: Learn(),
//       ),
//     );
//   }
// }

class Learn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const items = <String>[
      '讀書計畫',
      '筆記',
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('學習', style: TextStyle(fontSize: 22)),
        ),
        body: ListView.separated(
          itemCount: items.length,
          itemBuilder: (context, index) => Container(
              margin: EdgeInsets.only(
                top: 5,
                left: 10,
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      items[index],
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Color(0xffCCCCCC),
                    ),
                  ),
                ],
              )),
          separatorBuilder: (context, index) => Divider(),
        ));
    // return MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Myday',
    //     home: Scaffold(
    //         appBar: AppBar(
    //           backgroundColor: Color(0xffF86D67),
    //           title: Text('學習', style: TextStyle(fontSize: 22)),
    //         ),
    //         body: ListView.separated(
    //           itemCount: items.length,
    //           itemBuilder: (context, index) => Container(
    //               margin: EdgeInsets.only(
    //                 top: 5,
    //                 left: 10,
    //               ),
    //               child: Column(
    //                 children: [
    //                   ListTile(
    //                     title: Text(
    //                       items[index],
    //                       style: TextStyle(fontSize: 20),
    //                     ),
    //                     trailing: Icon(
    //                       Icons.chevron_right,
    //                       color: Color(0xffCCCCCC),
    //                     ),
    //                   ),
    //                 ],
    //               )),
    //           separatorBuilder: (context, index) => Divider(),
    //         ),
    //         bottomNavigationBar: Container(
    //             child: Row(children: <Widget>[
    //           Expanded(
    //             // ignore: deprecated_member_use
    //             child: FlatButton(
    //               height: 50,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(0)),
    //               child: Text(
    //                 '首頁',
    //                 style: TextStyle(
    //                   fontSize: 20,
    //                 ),
    //               ),
    //               color: Color(0xffF86D67),
    //               textColor: Colors.white,
    //               onPressed: () {
    //                 Navigator.pushReplacementNamed(context, '/home');
    //               },
    //             ),
    //           ),
    //           Expanded(
    //             // ignore: deprecated_member_use
    //             child: FlatButton(
    //               height: 50,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(0)),
    //               child: Text(
    //                 '群組',
    //                 style: TextStyle(fontSize: 20),
    //               ),
    //               color: Color(0xffF86D67),
    //               textColor: Colors.white,
    //               onPressed: () {
    //                 Navigator.pushReplacementNamed(context, '/group');
    //               },
    //             ),
    //           ),
    //           Expanded(
    //             // ignore: deprecated_member_use
    //             child: FlatButton(
    //               height: 50,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(0)),
    //               child: Text(
    //                 '玩聚',
    //                 style: TextStyle(fontSize: 20),
    //               ),
    //               color: Color(0xffF86D67),
    //               textColor: Colors.white,
    //               onPressed: () {},
    //             ),
    //           ),
    //           Expanded(
    //             // ignore: deprecated_member_use
    //             child: FlatButton(
    //               height: 50,
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(0)),
    //               child: Text(
    //                 '學習',
    //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    //               ),
    //               color: Color(0xffF86D67),
    //               textColor: Color(0xffF6CA07),
    //               onPressed: () {
    //                 Navigator.push(context,
    //                     MaterialPageRoute(builder: (context) => LearnPage()));
    //               },
    //             ),
    //           ),
    //         ]))));
  }
}
