import 'package:flutter/material.dart';

Future<bool> groupJoinDialog(BuildContext context) async {
  final groupIDController = TextEditingController();
  String inputGroupID = '';

  return showDialog<bool>(
    context: context,
    barrierDismissible: true, //控制點擊對話框以外的區域是否隱藏對話框
    builder: (BuildContext context) {
      return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            '加入群組',
            textAlign: TextAlign.center,
          ),
          content: Container(
            height: 95,
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/search.png',
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text('群組ID：', style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
                Container(
                  height: 40.0,
                  margin: EdgeInsets.only(top: 15),
                  child: new TextField(
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Color(0xff070707),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Color(0xff7AAAD8)),
                        )),
                    controller: groupIDController,
                    onChanged: (text) {
                      inputGroupID = text;
                    },
                  )
                ),
              ],
            ),
          ),
          actions: [
            FlatButton(
              child: const Text('取消'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('確認'),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                print(inputGroupID);
                Navigator.of(context).pop(true);
              },
            )
          ]);
    },
  );
}
