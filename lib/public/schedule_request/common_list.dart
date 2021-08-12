import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:My_Day_app/public/alert.dart';

class CommonList with Request {
  BuildContext context;
  String uid;
  int groupNum;
  CommonList(this.uid, this.groupNum);

  commonList() async {
    Uri _url = Uri.parse(Request.url['common_list'] +
        "?uid=" +
        uid +
        "&groupNum=" +
        groupNum.toString());
    dynamic response = await http.get(_url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    var responseBody = json.decode(utf8.decode(response.bodyBytes));

    print('statusCode: ${response.statusCode}');
    print('body: ${utf8.decode(response.bodyBytes)}');
    print(responseBody);
    print(responseBody["response"]);

    if (responseBody["response"] == false) {
      await alert(context, '錯誤', responseBody['message']);
    } else if (responseBody["response"] == true) {
      return responseBody;
    }
  }
}
