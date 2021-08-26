import 'package:flutter/material.dart';

import 'package:My_Day_app/models/vote/vote_end_list_model.dart';
import 'package:My_Day_app/public/request.dart';

class GetEndList {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> data;
  VoteEndListModel _response;

  _request() async {
    Request request = Request();
    await request.voteEndList(context, data);
    _response = await request.getVoteEndList();
  }

  GetEndList({this.uid, this.groupNum}) {
    data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}