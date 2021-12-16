import 'dart:convert';
import 'dart:io';

import 'package:My_Day_app/public/note_request/edit.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/getImage.dart';
import 'package:My_Day_app/public/note_request/create_new.dart';
import 'package:My_Day_app/public/note_request/get.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/study/note_fail.dart';

class NotesEditPage extends StatefulWidget {
  int noteNum;
  NotesEditPage(this.noteNum);

  @override
  _NotesEditPage createState() => new _NotesEditPage(noteNum);
}

class _NotesEditPage extends State<NotesEditPage> {
  int noteNum;
  _NotesEditPage(this.noteNum);

  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getNoteRequest();
  }

  String _imgString;

  final notetypeName = TextEditingController();
  final notetitle = TextEditingController();
  final notecontent = TextEditingController();

  String _alertTitle = '編輯失敗';
  String _alertTxt = '請確認是否有填寫欄位';
  List<Asset> images;

  Future<GetNoteModel> _futureGetNote;
  GetNoteModel _getNote;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _getNoteRequest() async {
    print('$uid, $noteNum');
    Get get = Get(context: context, uid: uid, noteNum: noteNum);
    Future<GetNoteModel> futureNote = get.getData();
    GetNoteModel note = await futureNote;
    setState(() {
      _futureGetNote = futureNote;
      _getNote = note;

      notetitle.text = _getNote.title;
      notetypeName.text = _getNote.typeName;
      _imgString = note.content;
    });
  }

  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    String imgString = await imageToBase64(image);
    setState(() {
      _imgString = imgString;
    });
  }

  Future imageToBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    double _iconWidth = _sizing.width(5);
    double _appBarSize = _sizing.width(5.8);

    GetImage _getImage = GetImage(context);

    _submit() async {
      String typeName = notetypeName.text;
      String title = notetitle.text;
      String content = _imgString;

      var submitWidget;
      _submitWidgetfunc() async {
        return EditNote(
            context: context,
            uid: uid,
            noteNum: noteNum,
            typeName: typeName,
            title: title,
            content: content);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return FutureBuilder<GetNoteModel>(
        future: _futureGetNote,
        builder: (BuildContext context, AsyncSnapshot<GetNoteModel> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text(_getNote.title,
                    style: TextStyle(fontSize: _appBarSize)),
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SafeArea(
                child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () =>
                        FocusScope.of(context).requestFocus(FocusNode()),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(
                                  left: 30, right: 100, bottom: 15, top: 15),
                              child: Row(
                                children: [
                                  Text('標題: ', style: TextStyle(fontSize: 20)),
                                  Flexible(
                                      child: TextFormField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 20,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          color: Color(0xff707070),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: notetitle.text,
                                            // 保持光標在最後
                                            selection:
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        affinity: TextAffinity
                                                            .downstream,
                                                        offset: notetitle
                                                            .text.length)))),
                                    onChanged: (text) {
                                      setState(() {
                                        notetitle.text = text;
                                      });
                                    },
                                  )),
                                ],
                              )),
                          Container(
                              margin: EdgeInsets.only(left: 30, right: 150),
                              child: Row(
                                children: [
                                  Text('分類: ', style: TextStyle(fontSize: 20)),
                                  Flexible(
                                      child: TextField(
                                    focusNode: focusNode,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 20,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        borderSide: BorderSide(
                                          color: Color(0xff707070),
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(
                                            text: notetypeName.text,
                                            // 保持光標在最後
                                            selection:
                                                TextSelection.fromPosition(
                                                    TextPosition(
                                                        affinity: TextAffinity
                                                            .downstream,
                                                        offset: notetypeName
                                                            .text.length)))),
                                    onChanged: (text) {
                                      setState(() {
                                        notetypeName.text = text;
                                      });
                                    },
                                  )),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Container(
                                margin: EdgeInsets.only(top: 4.0),
                                color: Color(0xffE3E3E3),
                                constraints: BoxConstraints.expand(height: 1.0),
                              )),
                          Container(
                              margin: EdgeInsets.only(right: 220),
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Theme.of(context).primaryColor,
                                ),
                                child: Text('上傳圖片',
                                    style: TextStyle(fontSize: 18)),
                                onPressed: _openGallery,
                              )),
                          Expanded(
                            child: _getImage.note(_imgString),
                          ),
                        ])),
              ),
              bottomNavigationBar: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                            ),
                            child: Image.asset(
                              'assets/images/cancel.png',
                              width: _iconWidth,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            backgroundColor: Theme.of(context).primaryColor,
                          ),
                          child: Image.asset(
                            'assets/images/confirm.png',
                            width: _iconWidth,
                          ),
                          onPressed: () async {
                            if (await _submit() != true) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
