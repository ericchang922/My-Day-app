import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/public/toast.dart';
import 'package:flutter/material.dart';

alert(BuildContext context, String alertTitle, String alertTxt) async {
  double _height = MediaQuery.of(context).size.height;
  Color _color = Theme.of(context).primaryColor;
  return showDialog<String>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
      title: Text(alertTitle),
      content: Text(alertTxt),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('關閉', style: TextStyle(color: _color)),
        ),
      ],
    ),
  );
}

msgBox(BuildContext context, String msgTitle, String msgTxt,
    Function function) async {
  Color _color = Theme.of(context).primaryColor;
  Sizing _sizing = Sizing(context);

  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(_sizing.height(3)))),
            title: Text(msgTitle),
            content: Text(msgTxt),
            actions: <Widget>[
              TextButton(
                onPressed: () async{
                  await function();
                  toast(context, '已刪除');
                  Navigator.pop(context);
                },
                child: Text('確定', style: TextStyle(color: _color)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('關閉', style: TextStyle(color: _color)),
              )
            ],
          ));
}
