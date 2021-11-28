import 'package:flutter/material.dart';

Future<bool> loginfailDialog(
    BuildContext context, String alertTitle, String alertTxt) async {
  double _height = MediaQuery.of(context).size.height;

  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
      title: Text(alertTitle),
      content: Text(alertTxt),
    ),
  );
}

Future<bool> forgetfailDialog(
    BuildContext context, String alertTitle, String alertTxt) async {
  double _height = MediaQuery.of(context).size.height;

  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
      title: Text(alertTitle),
      content: Text(alertTxt),
    ),
  );
}

Future<bool> changefailDialog(
    BuildContext context, String alertTitle, String alertTxt) async {
  double _height = MediaQuery.of(context).size.height;

  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
      title: Text(alertTitle),
      content: Text(alertTxt),
    ),
  );
}

Future<bool> codefailDialog(
    BuildContext context, String alertTitle, String alertTxt) async {
  double _height = MediaQuery.of(context).size.height;

  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_height * 0.03))),
      title: Text(alertTitle),
      content: Text(alertTxt),
    ),
  );
}
