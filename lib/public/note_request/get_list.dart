import 'package:My_Day_app/models/note/note_list_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class GetList {
  BuildContext context;
  String uid;
  Map<String, String> _data;
  NoteListModel _response;

  _request() async {
    Request request = Request();
    await request.noteGetList(context, _data);
    this._response = await request.getNoteList();
  }

  GetList({this.uid}) {
    _data = {'uid': uid};
  }

  Future<NoteListModel> getData() async {
    await _request();
    return this._response;
  }
}
