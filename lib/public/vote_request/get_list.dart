import 'package:flutter/material.dart';

import 'package:My_Day_app/models/vote/vote_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class GetList {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  VoteListModel _response;

  _request() async {
    Request request = Request();
    await request.voteList(context, data);
    _response = await request.getVoteList();
  }

  GetList({this.context, this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
