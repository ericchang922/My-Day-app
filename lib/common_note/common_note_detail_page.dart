import 'package:flutter/material.dart';

import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/note_request/get.dart';
import 'package:My_Day_app/public/sizing.dart';

class CommonNoteDetailPage extends StatefulWidget {
  int noteNum;
  CommonNoteDetailPage(this.noteNum);

  @override
  _CommonNoteDetailPage createState() => new _CommonNoteDetailPage(noteNum);
}

class _CommonNoteDetailPage extends State<CommonNoteDetailPage> {
  int noteNum;
  _CommonNoteDetailPage(this.noteNum);

  GetNoteModel _getNote;

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getNoteRequest();
  }

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getNoteRequest() async {
    GetNoteModel _request =
        await Get(context: context, uid: uid, noteNum: noteNum).getData();

    setState(() {
      _getNote = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;

    GetImage _getImage = GetImage(context);

    if (_getNote != null) {
      return Container(
          color: _color,
          child: SafeArea(
              bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: _color,
                  title: Text(_getNote.title,
                      style: TextStyle(fontSize: _appBarSize)),
                  leading: Container(
                    margin: EdgeInsets.only(left: _leadingL),
                    child: GestureDetector(
                      child: Icon(Icons.chevron_left),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  child: SafeArea(
                    top: false,
                    child: Center(child: _getImage.note(_getNote.content)),
                  ),
                ),
              )));
    } else {
      return Container(
          color: Colors.white,
          child: SafeArea(child: Center(child: CircularProgressIndicator())));
    }
  }
}
