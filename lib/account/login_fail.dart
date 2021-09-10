import 'package:My_Day_app/account/login.dart';
import 'package:flutter/material.dart';

Future<bool> loginfailDialog(BuildContext context,String alertTitle, String alertTxt) async {
 double _height = MediaQuery.of(context).size.height;
  Color _color = Theme.of(context).primaryColor;

  return showDialog<bool>(
          context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
          title: Text(alertTitle),
          content: Text(alertTxt),
                actions: <Widget>[                     
                InkWell(
                  child: Text("關閉",
                    style: TextStyle(color: _color),
                  ),               
                onTap: () {
                  Navigator.push(context,
                    MaterialPageRoute( builder: (context) => LoginPage()));
                },
              ),
              ],
            ),
      );
  }


