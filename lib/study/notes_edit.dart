import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/note_request/create_new.dart';
import 'package:My_Day_app/public/note_request/get.dart';
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

  var _imgPath;
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _getNoteRequest();
  }

  final notetypeName = TextEditingController();
  final notetitle = TextEditingController();
  final notecontent = TextEditingController();

  String _alertTitle = '新增失敗';
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
    });
  }

  /*图片控件*/
  Widget _ImageView(imgPath) {
    if (imgPath == null) {
      return Center(
        child: Text(""),
      );
    } else {
      return Image.file(
        imgPath,
      );
    }
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
      return Center(
        child: Text('無法讀取'),
      );
    }
  }

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }

  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _iconWidth = _width * 0.05;
    double _appBarSize = _width * 0.058;

    _submit() async {
      String typeName = notetypeName.text;
      String title = notetitle.text;
      String content = _imgPath.toString();

      var submitWidget;
      _submitWidgetfunc() async {
        return CreateNewNote(
            uid: uid, typeName: typeName, title: title, content: content);
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
                    // 點擊空白處釋放焦點
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
                                    controller: notetitle,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 20,
                                    minLines: 1,
                                    decoration: InputDecoration(
                                      isCollapsed: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)), //设置边框四个角的弧度
                                        borderSide: BorderSide(
                                          //用来配置边框的样式
                                          color: Color(0xff707070), //设置边框的颜色
                                          width: 2.0, //设置边框的粗细
                                        ),
                                      ),
                                    ),
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
                                    controller: notetypeName,
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
                                            Radius.circular(10)), //设置边框四个角的弧度
                                        borderSide: BorderSide(
                                          //用来配置边框的样式
                                          color: Color(0xff707070), //设置边框的颜色
                                          width: 2.0, //设置边框的粗细
                                        ),
                                      ),
                                    ),
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
                            child: _ImageView(_imgPath),
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
                            if (notetypeName.text.isNotEmpty &&
                                notetitle.text.isNotEmpty) {
                              if (await _submit() != true) {
                                Navigator.of(context).pop();
                              }
                            } else {
                              await notefailDialog(
                                  context, _alertTitle, _alertTxt);
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
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
