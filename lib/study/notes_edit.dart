// import 'package:My_Day_app/main.dart';
import 'dart:convert';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/note_request/create_new.dart';
import 'package:My_Day_app/public/note_request/get.dart';
import 'package:My_Day_app/studyplan/note_fail.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
class NotesEditPage extends StatefulWidget {
  int noteNum;
  String uid;
  NotesEditPage();

  @override
  _NotesEditPage createState() => new _NotesEditPage();
}

class _NotesEditPage extends State<NotesEditPage> with RouteAware {
   int noteNum;
  String uid;
  _NotesEditPage();

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
  double _width = size.width;
  double _iconWidth = _width * 0.05;

    


    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset:false,
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('編輯筆記', style: TextStyle(fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: NotesAdd(),
        ));
  }
}

class NotesAdd extends StatefulWidget {
  @override
  _NotesAdd createState() => _NotesAdd();
}

class _NotesAdd extends State< NotesAdd> {
  var _imgPath;
  String noteid = "lili123";
  final notetypeName = TextEditingController();
  final notetitle = TextEditingController();
  final notecontent = TextEditingController();

  String _alertTitle = '新增失敗';
  String _alertTxt = '請確認是否有填寫欄位';
  List<Asset> images = List<Asset>();
  String _error = '';
  
  @override
  void initState() {
    super.initState();
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

  /*相册*/
  _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imgPath = image;
    });
  }


  final FocusNode focusNode = FocusNode();
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _iconWidth = _width * 0.05;

_submit() async { 
      String uid = noteid;
      String typeName = notetypeName.text;
      String title = notetitle.text;
      String content = _imgPath.toString();

      var submitWidget;
      _submitWidgetfunc() async {
        return CreateNewNote(uid: uid, typeName:  typeName , title:title, content:content);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    return  SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: GestureDetector(
      // 點擊空白處釋放焦點
      behavior: HitTestBehavior.translucent,
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 30, right: 100, bottom: 15,top:15),
                  child: Row(
                    children: [
                      Text('標題: ', style: TextStyle(fontSize: 20)),
                      Flexible(
                        child: TextField(
                          controller: notetitle,
                          // focusNode: focusNode,
                          keyboardType: TextInputType.multiline,
                          maxLines: 20,
                          minLines: 1,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
                    margin: EdgeInsets.only(right:220),
              child: TextButton(
                      style: TextButton.styleFrom(
                    primary: Color(0xffF86D67),
                  ),
                child: Text('上傳圖片',style: TextStyle(fontSize: 18) ),
                      
                onPressed: _openGallery,
              )),
              Expanded(
                child: _ImageView(_imgPath),
              ),
              
            ])),
            bottomNavigationBar: Container(
              child: Row(children: <Widget>[
                Expanded(
                  // ignore: deprecated_member_use
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        backgroundColor:Color(0xffFFAAA6)
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
                  // ignore: deprecated_member_use
                  child: SizedBox(
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                        backgroundColor: Color(0xffF86D67)
                        ),
                    
                    child: Image.asset(
                          'assets/images/confirm.png',
                          width: _iconWidth,
                        ),
                  
                    onPressed: () async{
                      if (notetypeName.text.isNotEmpty &&  
                            notetitle.text.isNotEmpty) 
                            {
                            if (await _submit() != true) {
                              Navigator.of(context).pop();
                            }
                          } else {
                            bool action = await notefailDialog(
                                context, _alertTitle, _alertTxt);
                          }
                      
                    },
                  ),
                ),
          )
            ]))));
  }
}

// class NotesAdd extends StatefulWidget {
//   @override
//   _NotesAdd createState() => _NotesAdd();
// }

// class _NotesAdd extends State<NotesAdd> {
//   get direction => null;
//   get border => null;
//   get decoration => null;
//   get child => null;
//   get btnCenterClickEvent => null;
//   get appBar => null;
//   var value;
//   int count = 0;
//    final FocusNode focusNode = FocusNode();
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SafeArea(
//         child: Scaffold(
//           resizeToAvoidBottomInset: false , 
//         body: GestureDetector(
//         onTap: () {
//           focusNode.unfocus();
//         },
//         child: ListView(
//           children: <Widget>[
//             Container(
//                 margin: EdgeInsets.only(left: 30, right: 100, bottom: 15,top:15),
//                 child: Row(
//                   children: [
//                     Text('標題: ', style: TextStyle(fontSize: 20)),
//                     Flexible(
//                       child: TextField(
//                         focusNode: focusNode,
//                         keyboardType: TextInputType.multiline,
//                         maxLines: 20,
//                         minLines: 1,
//                         decoration: InputDecoration(
//                           isCollapsed: true,
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(10)), //设置边框四个角的弧度
//                             borderSide: BorderSide(
//                               //用来配置边框的样式
//                               color: Color(0xff707070), //设置边框的颜色
//                               width: 2.0, //设置边框的粗细
//                             ),
//                           ),
//                         ),
//                       )),
//                   ],
//                 )),
//             Container(
//                 margin: EdgeInsets.only(left: 30, right: 150, bottom: 15),
//                 child: Row(
//                   children: [
//                     Text('分類: ', style: TextStyle(fontSize: 20)),
//                     Flexible(
//                       child: TextField(
//                         focusNode: focusNode,
//                       keyboardType: TextInputType.multiline,
//                       maxLines: 20,
//                       minLines: 1,
//                       decoration: InputDecoration(
//                         isCollapsed: true,
//                         contentPadding:
//                             EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(
//                               Radius.circular(10)), //设置边框四个角的弧度
//                           borderSide: BorderSide(
//                             //用来配置边框的样式
//                             color: Color(0xff707070), //设置边框的颜色
//                             width: 2.0, //设置边框的粗细
//                           ),
//                         ),
//                       ),
//                     )),
//                   ],
//                 )),
//             Padding(
//                 padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                 child: Container(
//                   margin: EdgeInsets.only(top: 4.0),
//                   color: Color(0xffE3E3E3),
//                   constraints: BoxConstraints.expand(height: 1.0),
//                 )),
//             Padding(
//               padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
//               // ignore: deprecated_member_use
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(
//                     '上傳檔案:',
//                     style: TextStyle(
//                       fontSize: 20,
//                     ),
//                   ),
//                   TextButton(
//                     style: TextButton.styleFrom(
//                   primary: Colors.black,
//                 ),
//                       child: Text(
//                         '瀏覽',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       onPressed: () {})
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
//               child: TextField(
//                 focusNode: focusNode,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 20,
//                 minLines: 1,
//                 decoration: InputDecoration(
//                   isCollapsed: true,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
//                     borderSide: BorderSide(
//                       //用来配置边框的样式
//                       color: Color(0xffE3E3E3), //设置边框的颜色
//                       width: 2.0, //设置边框的粗细
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
//               child: ListTile(
//                 title: Text('內容：', style: TextStyle(fontSize: 20)),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(left: 30.0, right: 26.0),
//               child: TextField(
//                 focusNode: focusNode,
//                 keyboardType: TextInputType.multiline,
//                 maxLines: 20,
//                 minLines: 1,
                
//                 decoration: InputDecoration(
//                   isCollapsed: true,
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 8, vertical: 120),
//                   border: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
//                     borderSide: BorderSide(
//                       //用来配置边框的样式
//                       color: Color(0xffE3E3E3), //设置边框的颜色
//                       width: 2.0, //设置边框的粗细
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     )));
//   }
// }
