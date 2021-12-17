import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/note_request/create_new.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/study/note_fail.dart';
import 'package:My_Day_app/public/alert.dart';

class NotesAddPage extends StatefulWidget {
  @override
  _NotesAddPage createState() => _NotesAddPage();
}

class _NotesAddPage extends State<NotesAddPage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);
  }

  final notetypeName = TextEditingController();
  final notetitle = TextEditingController();
  final notecontent = TextEditingController();
  final FocusNode focusNode = FocusNode();

  String _alertTitle = '新增失敗';
  String _alertTxt = '請確認是否有填寫欄位';

  var _imgPath;
  List<Asset> images = [];

  @override
  void initState() {
    super.initState();
    _uid();
  }

  Widget _imageView(imgPath) {
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

  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (_imgPath != null) {
        _imgPath = image;
      }
    });
  }

  Future imageToBase64(File file) async {
    try {
      List<int> imageBytes = await file.readAsBytes();
      return base64Encode(imageBytes);
    } catch (e) {
      alert(context, '請選擇圖片', '尚未選擇圖片');
    }
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _iconWidth = _sizing.width(5);
    double _bottomHeight = _sizing.height(7);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;

    _submit() async {
      String typeName = notetypeName.text;
      String title = notetitle.text;
      String content = await imageToBase64(_imgPath);

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

    return Container(
      color: _color,
      child: SafeArea(
          bottom: false,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('新增筆記', style: TextStyle(fontSize: 20)),
                leading: IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
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
                                    child: TextField(
                                  controller: notetitle,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 20,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Color(0xff707070),
                                        width: 2.0,
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      borderSide: BorderSide(
                                        color: Color(0xff707070),
                                        width: 2.0,
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
                              child:
                                  Text('上傳圖片', style: TextStyle(fontSize: 18)),
                              onPressed: _openGallery,
                            )),
                        Expanded(
                          child: _imageView(_imgPath),
                        ),
                      ])),
              bottomNavigationBar: Container(
                color: Theme.of(context).bottomAppBarColor,
                child: SafeArea(
                  top: false,
                  child: BottomAppBar(
                    elevation: 0,
                    child: Row(children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: _bottomHeight,
                          child: RawMaterialButton(
                              elevation: 0,
                              child: Image.asset(
                                'assets/images/cancel.png',
                                width: _iconWidth,
                              ),
                              fillColor: _light,
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: _bottomHeight,
                          child: RawMaterialButton(
                              elevation: 0,
                              child: Image.asset(
                                'assets/images/confirm.png',
                                width: _iconWidth,
                              ),
                              fillColor: _color,
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
                              }),
                        ),
                      )
                    ]),
                  ),
                ),
              ))),
    );
  }
}
