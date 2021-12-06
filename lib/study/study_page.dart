import 'package:flutter/material.dart';

import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/study/notes.dart';
import 'package:My_Day_app/study/studyplan_list_page.dart';

AppBar studyAppBar(context) {
  Sizing _sizing = Sizing(context);
  double _titleSize = _sizing.width(5.2);

  Color _color = Theme.of(context).primaryColor;

  return AppBar(
    backgroundColor: _color,
    title: Text('讀書', style: TextStyle(fontSize: _titleSize)),
  );
}

class StudyPage extends StatefulWidget {
  @override
  _StudyPage createState() => new _StudyPage();
}

class _StudyPage extends State<StudyPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(8);

    double _titleSize = _sizing.height(2.5);

    Color _lightGray = Color(0xffE3E3E3);

    Widget studyItem = Container(
      margin: EdgeInsets.only(top: _sizing.height(1)),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('讀書計畫', style: TextStyle(fontSize: _titleSize)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _lightGray,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StudyplanListPage()));
            },
          ),
          Divider(),
          ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            title: Text('筆記', style: TextStyle(fontSize: _titleSize)),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: _lightGray,
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NoteListWidget()));
            },
          ),
        ],
      ),
    );

    return Container(
        color: Colors.white, child: SafeArea(top: false, child: studyItem));
  }
}
