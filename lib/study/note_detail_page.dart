import 'dart:convert';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/note_request/delete.dart';

import 'package:My_Day_app/public/note_request/get.dart';
import 'package:My_Day_app/study/notes_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NoteDetailPage extends StatefulWidget {
  int noteNum;
  String uid;
  NoteDetailPage(this.uid, this.noteNum);

  @override
  _NoteDetailPage createState() => new _NoteDetailPage(uid, noteNum);
}

class _NoteDetailPage extends State<NoteDetailPage> with RouteAware {
  int noteNum;
  String uid = 'lili123';
  _NoteDetailPage(this.uid, this.noteNum);

  GetNoteModel _getNote;

  @override
  void initState() {
    super.initState();
    _getNoteRequest();
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
    _getNoteRequest();
  }

  _getNoteRequest() async {
    // var response = await rootBundle.loadString('assets/json/get_note.json');
    // var responseBody = json.decode(response);
    // var _request = GetNoteModel.fromJson(responseBody);

    GetNoteModel _request =
        await Get(context: context, uid: uid, noteNum: noteNum).getData();

    setState(() {
      _getNote = _request;
    });
    print(noteNum);
  }

  getImage(String imageString) {
    bool isGetImage;
    Image image;

    try {
      const Base64Codec base64 = Base64Codec();
      image = Image.memory(
        base64.decode(imageString),
      );
      var resolve = image.image.resolve(ImageConfiguration.empty);
      resolve.addListener(ImageStreamListener((_, __) {
        isGetImage = true;
      }, onError: (Object exception, StackTrace stackTrace) {
        isGetImage = false;
        print('error');
      }));
    } catch (error) {
      print('筆記圖片讀取錯誤：${error}');
      isGetImage = false;
    }

    if (isGetImage == null) {
      return image;
    } else {
      return Center(
        child: Text('無法讀取'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;
    double _leadingL = _height * 0.02;
    double _appBarSize = _width * 0.058;
    double _titleSize = _height * 0.025;
    double _pSize = _height * 0.023;
    double _subtitleSize = _height * 0.02;

    Color _color = Theme.of(context).primaryColor;

    _submitDelete() async {
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

    _selectedItem(BuildContext context, value) async {
      switch (value) {
        case 'edit':
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NotesEditPage(noteNum)));
          break;

        case 'delete':
          if (await _submitDelete() != true) {
            Navigator.pop(context);
          }
          break;
      }
    }

    _studyplanAction() {
      return PopupMenuButton<String>(
        offset: Offset(50, 50),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_height * 0.01)),
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
                    margin: EdgeInsets.only(top: _height * 0.01),
                    child: _studyplanAction())
              ],
            ),
            body: Container(
                color: Colors.white,
                child: SafeArea(
                    top: false,
                    child: Center(child: getImage(_getNote.content)))),
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
