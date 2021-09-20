// import 'package:My_Day_app/main.dart';
import 'package:flutter/material.dart';



class NotesAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      
        body: NotesAddPageWidget(),
      
    ));
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class NotesAddPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _iconWidth = _width * 0.05;
    return SafeArea(
        child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('新增筆記', style: TextStyle(fontSize: 20)),
          leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: NotesAdd(),
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
             
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
    )]))));
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
      home: SafeArea(
        child: Scaffold(
        body: ListView(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(left: 30, right: 100, bottom: 15),
                child: Row(
                  children: [
                    Text('標題: ', style: TextStyle(fontSize: 20)),
                    Flexible(
                        child: TextField(
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
                margin: EdgeInsets.only(left: 30, right: 150, bottom: 15),
                child: Row(
                  children: [
                    Text('分類: ', style: TextStyle(fontSize: 20)),
                    Flexible(
                        child: TextField(
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
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
              // ignore: deprecated_member_use
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    '上傳檔案:',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
                      child: Text(
                        '瀏覽',
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 20,
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
              margin: EdgeInsets.only(left: 30.0, right: 26.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 20,
                minLines: 1,
                
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 120),
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
    ));
  }
}
