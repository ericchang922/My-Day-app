import 'package:My_Day_app/models/note/note_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class NotShareList {
  BuildContext context;
  String uid;
  Map<String, String> _data;
  NoteListModel _response;

  _request() async {
    Request request = Request();
    await request.notShareNoteList(context, _data);
    this._response = await request.getNotShareNoteList();
  }

  NotShareList({this.uid, int noteNum}) {
    _data = {'uid': uid};
  }

  Future<NoteListModel> getData() async {
    await _request();
    return this._response;
  }
}
