
import 'package:My_Day_app/models/note/get_note_model.dart';
import 'package:My_Day_app/public/request.dart';
import 'package:flutter/material.dart';

class Get {
  BuildContext context;
  String uid;
  int noteNum;
  Map<String, String> _data;
  GetNoteModel _response;

  _request() async {
    Request request = Request();
    await request.noteGet(context, _data);
    this._response = await request.getNote();
  }

  Get({this.context, this.uid,this.noteNum}) {
    _data = {'uid': uid,'noteNum': noteNum.toString()};
  }

  Future<GetNoteModel> getData() async {
    await _request();
    return this._response;
  }
}
