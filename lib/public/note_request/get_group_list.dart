import 'package:My_Day_app/models/note/share_note_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class GetGroupList {
  BuildContext context;
  String uid;
  int groupNum;
  Map<String, String> _data;
  ShareNoteListModel _response;

  _request() async {
    Request request = Request();
    await request.noteGetGroupList(context, _data);
    this._response = await request.getShareNoteList();
  }

  GetGroupList({this.uid, this.groupNum}) {
    _data = {'uid': uid, 'groupNum': groupNum.toString()};
  }

  Future<ShareNoteListModel> getData() async {
    await _request();
    return this._response;
  }
}
