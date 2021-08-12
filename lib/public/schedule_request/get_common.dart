import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:My_Day_app/public/request.dart';
import 'package:My_Day_app/public/alert.dart';



class GetCommon with Request {
  BuildContext context;
  String uid;
  int scheduleNum;
  GetCommon(this.uid, this.scheduleNum);

  getCommon() async {
    Uri _url = Uri.parse(Request.url['get_common'] +
        "?uid=" +
        uid +
        "&scheduleNum=" +
        scheduleNum.toString());
    dynamic response = await http.get(_url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');

    if (responseBody["response"] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody["response"] == true) {
      return responseBody;
    }
  }
}