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