import 'package:flutter/material.dart';
import 'package:My_Day_app/public/request.dart';

class CreateNew {
  BuildContext context;
  String uid;
  int groupNum;
  int optionTypeId;
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
    await request.voteCreateNew(context, data);
    this._isError = await request.getIsError();
  }

  CreateNew(
      {this.context,
      this.uid,
      this.groupNum,
      this.optionTypeId,
      this.title,
      this.voteItems,
      this.deadline,
      this.isAddItemPermit,
      this.isAnonymous,
      this.chooseVoteQuantity}) {
    data = {
      'uid': uid,
      'groupNum': groupNum,
      'optionTypeId': optionTypeId,
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
