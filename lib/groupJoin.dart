import 'package:flutter/material.dart';

class GroupJoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupJoinWidget(),
    );
  }
}

class GroupJoinWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('加入群組',style: TextStyle(fontSize: 20)),
        ),
        body: _GroupJoin()
    );
  }
}

class _GroupJoin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('新增群組'),
    );
  }
}
    