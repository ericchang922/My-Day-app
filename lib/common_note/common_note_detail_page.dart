import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/note_request/get.dart';
import 'package:flutter/material.dart';

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

  String uid = 'lili123';

  @override
  void initState() {
    super.initState();
    _getNoteRequest();
  }

  _getNoteRequest() async {
    // var response = await rootBundle.loadString('assets/json/get_note.json');
    // var responseBody = json.decode(response);
    // var _request = GetNoteModel.fromJson(responseBody);

    GetNoteModel _request = await Get(uid: uid, noteNum: noteNum).getData();

    setState(() {
      _getNote = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _leadingL = _height * 0.02;
    double _appBarSize = _width * 0.052;

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
