import 'package:flutter/material.dart';

import 'package:My_Day_app/study/note_detail_page.dart';
import 'package:My_Day_app/study/notes_add.dart';
import 'package:My_Day_app/models/note/note_list_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/note_request/get_list.dart';
import 'package:My_Day_app/public/sizing.dart';

AppBar noteListAppBar(context) {
  return null;
}

class NoteListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NoteListWidget();
  }
}

class NoteListWidget extends StatefulWidget {
  @override
  _NoteListState createState() => new _NoteListState();
}

class _NoteListState extends State<NoteListWidget> {
  NoteListModel _noteList;
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getNoteListRequest();
  }

  int noteNum;
  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getNoteListRequest() async {
    print(uid + 'note.dart======================================');
    NoteListModel _request =
        await GetList(context: context, uid: uid, noteNum: noteNum).getData();

    setState(() {
      _noteList = _request;
    });
  }

  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _listPaddingH = _sizing.width(6);
    double _titleSize = _sizing.height(2.5);

    Color _color = Theme.of(context).primaryColor;

    Widget noteListWiget;

    if (_noteList != null) {
      Widget noteList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _noteList.note.length,
        itemBuilder: (BuildContext context, int index) {
          var note = _noteList.note[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => NoteDetailPage(uid, note.noteNum)));
            },
            title: Text(
              '${note.title} ',
              style: TextStyle(fontSize: _titleSize),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );
      if (_noteList.note.length == 0) {
        noteListWiget = Center(child: Text('目前沒有任何筆記！'));
      } else {
        noteListWiget = ListView(
          padding: EdgeInsets.only(top: _sizing.width(3)),
          children: [noteList],
        );
      }

      return Container(
        color: _color,
        child: SafeArea(
          top: false,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('筆記', style: TextStyle(fontSize: 20)),
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesAddPage()))
                        .then((value) => _getNoteListRequest());
                  },
                ),
              ],
            ),
            body: Container(child: noteListWiget),
          ),
        ),
      );
    } else {
      return Container(
          color: _color,
          child: SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text('筆記', style: TextStyle(fontSize: 20)),
              leading: IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotesAddPage()))
                        .then((value) => _getNoteListRequest());
                  },
                ),
              ],
            ),
            body: Center(child: CircularProgressIndicator()),
          )));
    }
  }
}
