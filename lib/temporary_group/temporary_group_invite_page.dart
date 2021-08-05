import 'dart:convert';

import 'package:My_Day_app/models/get_temporary_group_invitet_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TemporaryGroupInvitePage extends StatefulWidget {
  int groupNum;
  TemporaryGroupInvitePage(this.groupNum);

  @override
  TemporaryGroupInviteWidget createState() =>
      new TemporaryGroupInviteWidget(groupNum);
}

class TemporaryGroupInviteWidget extends State<TemporaryGroupInvitePage> {
  int groupNum;
  TemporaryGroupInviteWidget(this.groupNum);

  String uid = 'lili123';

  GetTemporaryGroupInvitetModel _getTemporaryGroupInviteModel = null;

  @override
  void initState() {
    super.initState();
    _getTemporaryGroupInviteRequest();
  }

  Future _getTemporaryGroupInviteRequest() async {
    var jsonString = await rootBundle
        .loadString('assets/json/get_temporary_group_invite.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(
    //     Uri.http('myday.sytes.net', '/group/group_list/', {'uid': uid}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var getTemporaryGroupInviteModel =
        GetTemporaryGroupInvitetModel.fromJson(jsonMap);
    setState(() {
      _getTemporaryGroupInviteModel = getTemporaryGroupInviteModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if(_getTemporaryGroupInviteModel != null){
      return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            leading: Container(
              margin: EdgeInsets.only(left: screenSize.height * 0.02),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: Text(_getTemporaryGroupInviteModel.title,
                style: TextStyle(fontSize: screenSize.width * 0.052))),
        body: Container(color: Colors.white, child: Container()));
    }else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
