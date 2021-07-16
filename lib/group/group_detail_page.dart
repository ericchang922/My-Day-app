import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class GroupDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('學生會', style: TextStyle(fontSize: 22)),
      ),
      body: GroupDetail(),
    );
  }
}

class GroupDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('detail'),
    );
  }
}
