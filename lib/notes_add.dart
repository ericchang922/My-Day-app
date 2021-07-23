// import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';

import 'learn.dart';
import 'main.dart';
import 'notes.dart';

class NotesAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomePageWidget(),
       
        '/learn' : (BuildContext context) => new LearnPage(),
      },
      home: Scaffold(
        body: NotesAddPageWidget(),
      ),
    );
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class NotesAddPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title:Text('新增筆記',style: TextStyle(fontSize: 20)),
        leading:IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotesPage()));
          },
        ), 
      ),
      body: NotesAdd(),
        bottomNavigationBar: Container(
            child: Row(children: <Widget>[
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                '取消',
                style: TextStyle(fontSize: 18),
              ),
              color: Color(0xffFFAAA6),
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotesPage()));
              },
            ),
          ),
          Expanded(
            // ignore: deprecated_member_use
            child: FlatButton(
              height: 50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Text(
                '確認',
                style: TextStyle(fontSize: 18),
              ),
              color: Color(0xffF86D67),
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NotesPage()));
              },
            ),
          ),
        ])));
  }
}
class NotesAdd extends StatefulWidget {
  @override
  _NotesAdd createState() => _NotesAdd();
}
class _NotesAdd extends State<NotesAdd> {
  get direction => null;
  get border => null;
  get decoration => null;
  get child => null;
  get btnCenterClickEvent => null;
  get appBar => null;
  var value;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
              margin:EdgeInsets.only(left:30,right:100,bottom:15),
              child:Row(
                children: [
                  Text('標題: ',style: TextStyle(fontSize: 20)),
                  Flexible(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines:20,
                        minLines: 1,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                              BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
                            borderSide: BorderSide(
                              //用来配置边框的样式
                              color: Color(0xff707070), //设置边框的颜色
                              width: 2.0, //设置边框的粗细
                            ),
                          ),
                        ),
                  )),  
                ],)
            ),
            Container(
              margin:EdgeInsets.only(left:30,right:150,bottom:15),
              child:Row(
                children: [
                  Text('分類: ',style: TextStyle(fontSize: 20)),
                  Flexible(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines:20,
                        minLines: 1,
                        decoration: InputDecoration(
                          isCollapsed: true,
                          contentPadding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                              BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
                            borderSide: BorderSide(
                              //用来配置边框的样式
                              color: Color(0xff707070), //设置边框的颜色
                              width: 2.0, //设置边框的粗细
                            ),
                          ),
                        ),
                  )),  
                ],)
            ),  
            Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                margin: EdgeInsets.only(top: 4.0),
                color: Color(0xffE3E3E3),
                constraints: BoxConstraints.expand(height: 1.0),
              )),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
              // ignore: deprecated_member_use
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('上傳檔案:',style: TextStyle(fontSize: 20,),
                  ),
                  FlatButton(
                    child: Text('瀏覽',style: TextStyle(fontSize: 18),
                    ),
                    onPressed: (){

                    }
                  )],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines:20,
                minLines: 1,
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius:
                      BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
                    borderSide: BorderSide(
                      //用来配置边框的样式
                      color: Color(0xffE3E3E3), //设置边框的颜色
                      width: 2.0, //设置边框的粗细
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: ListTile(
                title: Text('內容：', style: TextStyle(fontSize: 20)),
              ),
            ),
              Container(  
                margin:EdgeInsets.only(left:30.0,right:26.0),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines:20,
                  minLines: 1,
                  style: TextStyle(
                    fontSize: 150,             
                  ),
                  decoration: InputDecoration(
                    isCollapsed: true,
                    contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius:
                        BorderRadius.all(Radius.circular(10)), //设置边框四个角的弧度
                      borderSide: BorderSide(
                        //用来配置边框的样式
                        color: Color(0xffE3E3E3), //设置边框的颜色
                        width: 2.0, //设置边框的粗细
                      ),
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}



