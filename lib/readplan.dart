// import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';

import 'learn.dart';
import 'home.dart';


class ReadPlanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new Home(),
        
        '/learn' : (BuildContext context) => new LearnPage(),
      },
      home: Scaffold(
        body: ReadPlanPageWidget(),
      ),
    );
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class ReadPlanPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title:Text('讀書計畫',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LearnPage()));
          },
        ), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LearnPage()));
            },
          ),
        ],
      ),  
    );
  }
}



