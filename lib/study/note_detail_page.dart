import 'dart:convert';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/note_request/get.dart';
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
  String uid;
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
    var response = await rootBundle.loadString('assets/json/get_note.json');
    var responseBody = json.decode(response);

    GetNoteModel _request = await Get(uid: uid, noteNum: noteNum).getData();

    setState(() {
      _getNote = _request;
    });
  }

  getImage(String imageString) {
    bool isGetImage;
    
    const Base64Codec base64 = Base64Codec();
    Image image = Image.memory(
      base64.decode(imageString),
    );
    var resolve = image.image.resolve(ImageConfiguration.empty);
    resolve.addListener(ImageStreamListener((_, __) {
      isGetImage = true;
    }, onError: (Object exception, StackTrace stackTrace) {
      isGetImage = false;
      print('error');
    }));

    if (isGetImage == null) {
      return image;
    } else {
      return 
      Center(
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
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;

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
            ),
            body: Container(
                color: Colors.white,
                child: SafeArea(top: false, child: getImage(_getNote.content))),
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
