import 'package:flutter/material.dart';

import 'package:My_Day_app/models/vote/get_vote_model.dart';
import 'package:My_Day_app/public/request.dart';

class Get {
  BuildContext context;
  String uid;
  int voteNum;
  Map<String, String> data;
  GetVoteModel _response;

  _request() async {
    Request request = Request();
    await request.voteGet(context, data);
    _response = await request.getVote();
  }

  Get({this.uid, this.voteNum}) {
    data = {'uid': uid, 'voteNum': voteNum.toString()};
  }

  getData() async {
    await _request();
    return this._response;
  }
}
