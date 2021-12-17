import 'package:flutter/material.dart';

import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/note_request/delete.dart';
import 'package:My_Day_app/public/note_request/get.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/study/notes_edit.dart';

class NoteDetailPage extends StatefulWidget {
  int noteNum;
  String uid;
  NoteDetailPage(this.uid, this.noteNum);

  @override
  _NoteDetailPage createState() => new _NoteDetailPage(uid, noteNum);
}

class _NoteDetailPage extends State<NoteDetailPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getNoteRequest();
  }

  int noteNum;
  _NoteDetailPage(this.uid, this.noteNum);

  GetNoteModel _getNote;

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
    print(noteNum);
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _leadingL = _sizing.height(2);
    double _appBarSize = _sizing.width(5.8);
    double _subtitleSize = _sizing.height(2);

    Color _color = Theme.of(context).primaryColor;

    GetImage _getImage = GetImage(context);

    _submitDelete() async {
      DeleteNote deleteNote =
          DeleteNote(context: context, uid: uid, noteNum: noteNum);
      print('note delete $uid, $noteNum');
      return await deleteNote.getIsError();
    }

    _selectedItem(BuildContext context, value) async {
      switch (value) {
        case 'edit':
          Navigator.of(context)
              .push(MaterialPageRoute(
                  builder: (context) => NotesEditPage(noteNum)))
              .then((value) => _getNoteRequest());
          break;

        case 'delete':
          if (await _submitDelete() != true) {
            Navigator.of(context).pop();
          }
          break;
      }
    }

    _studyplanAction() {
      return PopupMenuButton<String>(
        offset: Offset(50, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_sizing.height(1))),
        icon: Icon(Icons.more_vert),
        itemBuilder: (context) => [
          PopupMenuItem<String>(
              value: 'edit',
              child: Container(
                  alignment: Alignment.center,
                  child:
                      Text("編輯", style: TextStyle(fontSize: _subtitleSize)))),
          PopupMenuDivider(
            height: 1,
          ),
          PopupMenuItem<String>(
              value: 'delete',
              child: Container(
                  alignment: Alignment.center,
                  child:
                      Text("刪除", style: TextStyle(fontSize: _subtitleSize)))),
        ],
        onSelected: (value) => _selectedItem(context, value),
      );
    }

    if (_getNote != null) {
      return Container(
        color: _color,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title:
                  Text(_getNote.title, style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              actions: [
                Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: _sizing.height(1)),
                    child: _studyplanAction())
              ],
            ),
            body: Container(
                color: Colors.white,
                child: SafeArea(
                    top: false,
                    child: Center(child: _getImage.note(_getNote.content)))),
          ),
        ),
      );
    } else {
      return Container(
          color: Colors.white,
          child: SafeArea(child: Center(child: CircularProgressIndicator())));
    }
  }
}
