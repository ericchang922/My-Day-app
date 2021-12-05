import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

Future<bool> notefailDialog(
    BuildContext context, String alertTitle, String alertTxt) async {
  Sizing _sizing = Sizing(context);
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_sizing.height(3)))),
      title: Text(alertTitle),
      content: Text(alertTxt),
    ),
  );
}
