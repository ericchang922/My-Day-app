import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

AppBar homePageAppBar(context) {
  Color color = Theme.of(context).primaryColor;
  return AppBar(
    title: Text('首頁'),
    backgroundColor: color,
  );
}
