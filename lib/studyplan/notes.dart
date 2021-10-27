
import 'package:My_Day_app/common_note/common_note_detail_page.dart';
import 'package:My_Day_app/models/note/note_list_model.dart';
import 'package:My_Day_app/public/note_request/delete.dart';
import 'package:My_Day_app/public/note_request/get_list.dart';
import 'package:My_Day_app/studyplan/note_detail_page.dart';
import 'package:My_Day_app/studyplan/notes_add.dart';
import 'package:My_Day_app/studyplan/notes_edit.dart';
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
  NoteListModel _noteListModel;
  String uid = 'lili123';
  
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

    NoteListModel _request = await GetList(uid: uid).getData();

    setState(() {
      _noteListModel = _request;
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

    Color _bule = Color(0xff7AAAD8);
    Color _gray = Color(0xff959595);
    Color _color = Theme.of(context).primaryColor;
    List<String> _list = ["Apple", "Ball", "Cat", "Dog", "Elephant"];
    Widget noteListWiget;

    _submitDelete(int noteNum) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return DeleteNote(uid: uid, noteNum: noteNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }
    _popupMenu(String id, int noteNum) {
      if (id == uid) {
        return PopupMenuButton(
          offset: Offset(-40, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_height * 0.01)),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: Text("刪除",
                        style: TextStyle(fontSize: _subtitleSize))),
              ),
            ];
          },
          onSelected: (int value) async {
            if (await _submitDelete(noteNum) != true) {
              _getNoteListRequest()();
            }
          },
        );
      }
    }

      Widget noteList = ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _noteListModel.note.length,
        itemBuilder: (BuildContext context, int index) {
          var note = _noteListModel.note[index];
          return ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: _listPaddingH, vertical: 0.0),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          NoteDetailPage(uid,note.noteNum)));
            },
            title: Text(
              '${note.title} ',
              style: TextStyle(fontSize: _titleSize),
            ),
            trailing: _popupMenu(uid, note.noteNum),
                );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
      );

      Widget noGroup = Center(child: Text('目前沒有任何筆記喔！'));

       if (_noteListModel.note.length != 0) {
        noteListWiget = ListView(
          padding: EdgeInsets.only(top: _width * 0.03),
          children: [noteList],
        );
      } else
        noteListWiget = noGroup;

      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF86D67),
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
        body: Container(child: noteListWiget
    //   child: ReorderableListView(
    //     children: _list
    //         .map((item) => ListTile(
    //               key: Key("${item}"),
    //               title: Text("${item}"),
    //               trailing: Icon(Icons.menu),
    //             ))
    //         .toList(),
    //     onReorder: (int start, int current) {
    //       // dragging from top to bottom
    //       if (start < current) {
    //         int end = current - 1;
    //         String startItem = _list[start];
    //         int i = 0;
    //         int local = start;
    //         do {
    //           _list[local] = _list[++local];
    //           i++;
    //         } while (i < end - start);
    //         _list[end] = startItem;
    //       }
    //       // dragging from bottom to top
    //       else if (start > current) {
    //         String startItem = _list[start];
    //         for (int i = start; i > current; i--) {
    //           _list[i] = _list[i - 1];
    //         }
    //         _list[current] = startItem;
    //       }
    //       setState(() {});
    //     },
    //   ),
    // )
      )));
    } 
  }


