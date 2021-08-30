import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class Edit {
  BuildContext context;
  String uid;
  int voteNum;
  String title;
  List<Map<String, dynamic>> voteItems;
  String deadline;
  bool isAddItemPermit;
  bool isAnonymous;
  int chooseVoteQuantity;
  Map<String, dynamic> data;

  bool _isError;

  _request() async {
    Request request = Request();
    await request.voteEdit(context, data);
    this._isError = await request.getIsError();
  }

  Edit(
      {this.context,
      this.uid,
      this.voteNum,
      this.title,
      this.voteItems,
      this.deadline,
      this.isAddItemPermit,
      this.isAnonymous,
      this.chooseVoteQuantity}) {
    data = {
      'uid': uid,
      'voteNum': voteNum,
      'title': title,
      'voteItems': voteItems,
      'deadline': deadline,
      'isAddItemPermit': isAddItemPermit,
      'isAnonymous': isAnonymous,
      'chooseVoteQuantity': chooseVoteQuantity
    };
  }

  getIsError() async {
    await _request();
    return this._isError;
  }
}
