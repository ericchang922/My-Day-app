import 'package:My_Day_app/models/note/note_list_model.dart';
import 'package:My_Day_app/public/note_request/delete.dart';
import 'package:My_Day_app/public/note_request/get_list.dart';
import 'package:My_Day_app/study/note_detail_page.dart';
import 'package:My_Day_app/study/notes_add.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/main.dart';

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

class _NoteListState extends State<NoteListWidget> with RouteAware {
  NoteListModel _noteList;
  String uid = 'lili123';
  int noteNum;
  @override
  void initState() {
    super.initState();
    _getNoteListRequest();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    _getNoteListRequest();
  }

  _getNoteListRequest() async {
    // var response = await rootBundle.loadString('assets/json/group_list.json');
    // var responseBody = json.decode(response);

    NoteListModel _request =
        await GetList(context: context, uid: uid, noteNum: noteNum).getData();

    setState(() {
      _noteList = _request;
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _listPaddingH = _width * 0.06;
    double _widthSize = _width * 0.01;
    double _textL = _height * 0.03;
    double _textBT = _height * 0.02;
    double _subtitleT = _height * 0.005;

    double _appBarSize = _width * 0.052;
    double _p2Size = _height * 0.02;
    double _pSize = _height * 0.023;
    double _titleSize = _height * 0.025;
    double _subtitleSize = _height * 0.02;
    double _typeSize = _width * 0.045;

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
          padding: EdgeInsets.only(top: _width * 0.03),
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
                            builder: (context) => NotesAddPage()));
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
                            builder: (context) => NotesAddPage()));
                  },
                ),
              ],
            ),
            body: Center(child: CircularProgressIndicator()),
          )));
    }
  }
}
