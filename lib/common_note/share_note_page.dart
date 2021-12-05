import 'package:flutter/material.dart';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/note_request/share.dart';
import 'package:My_Day_app/public/note_request/get_group_list.dart';
import 'package:My_Day_app/public/note_request/get_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/models/note/share_note_list_model.dart';
import 'package:My_Day_app/models/note/note_list_model.dart';
import 'package:My_Day_app/public/sizing.dart';

class ShareNotePage extends StatefulWidget {
  int groupNum;
  ShareNotePage(this.groupNum);

  @override
  _ShareNoteWidget createState() => new _ShareNoteWidget(groupNum);
}

class _ShareNoteWidget extends State<ShareNotePage> {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _noteListRequest();
  }

  int groupNum;
  _ShareNoteWidget(this.groupNum);

  List _noteListModel = [];
  ShareNoteListModel _shareNoteList;

  int noteNum;

  List _noteCheck = [];

  @override
  void initState() {
    super.initState();
    _uid();
  }

  _noteListRequest() async {
    ShareNoteListModel _shareNoteListRequest =
        await GetGroupList(context: context, uid: uid, groupNum: groupNum)
            .getData();

    NoteListModel _noteList =
        await GetList(context: context, uid: uid).getData();

    setState(() {
      _shareNoteList = _shareNoteListRequest;
      for (int i = 0; i < _noteList.note.length; i++) {
        int count = 0;
        var note = _noteList.note[i];
        for (int j = 0; j < _shareNoteList.note.length; j++) {
          var groupNote = _shareNoteList.note[j];
          if (note.noteNum == groupNote.noteNum) count++;
        }
        if (count == 0) {
          _noteListModel.add(note);
        }
      }
      for (int i = 0; i < _noteListModel.length; i++) {
        _noteCheck.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);
    double _bottomHeight = _sizing.height(7);
    double _bottomIconWidth = _sizing.width(5);

    double _titleSize = _sizing.height(2.5);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;
    Color _hintGray = Color(0xffCCCCCC);

    Widget noNote = Center(child: Text('目前沒有任何筆記!'));
    Widget noteList;

    _submitShare(int noteNum) async {
      String _alertTitle = '分享筆記失敗';
      if (noteNum == null) {
        await alert(context, _alertTitle, '請選擇一個要分享的筆記');
        return true;
      } else {
        Share share = Share(context: context , uid: uid, noteNum: noteNum, groupNum: groupNum);

        if (await share.getIsError())
          return true;
        else
          return false;
      }
    }

    int _noteCount() {
      int _noteCount = 0;
      for (int i = 0; i < _noteCheck.length; i++) {
        if (_noteCheck[i] == true) {
          _noteCount++;
        }
      }
      return _noteCount;
    }

    if (_noteListModel != null && _shareNoteList != null) {
      if (_noteListModel.length == 0) {
        noteList = noNote;
      } else {
        noteList = ListView.separated(
            itemCount: _noteListModel.length,
            itemBuilder: (BuildContext context, int index) {
              var note = _noteListModel[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _sizing.height(3),
                    vertical: _sizing.height(0.8)),
                title: Container(
                  margin: EdgeInsets.only(left: _sizing.height(1)),
                  child:
                      Text(note.title, style: TextStyle(fontSize: _titleSize)),
                ),
                trailing: CustomerCheckBox(
                  value: _noteCheck[index],
                  onTap: (value) {
                    setState(() {
                      if (value == true) {
                        if (_noteCount() < 1) {
                          _noteCheck[index] = value;
                          noteNum = note.noteNum;
                        }
                      } else {
                        _noteCheck[index] = value;
                      }
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    if (_noteCheck[index] == false) {
                      if (_noteCount() < 1) {
                        _noteCheck[index] = true;
                        noteNum = note.noteNum;
                      }
                    } else {
                      _noteCheck[index] = false;
                    }
                  });
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                height: 1,
              );
            });
      }
    } else {
      noteList = Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()));
    }

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('選擇筆記', style: TextStyle(fontSize: _appBarSize)),
            leading: Container(
              margin: EdgeInsets.only(left: _leadingL),
              child: GestureDetector(
                child: Icon(Icons.chevron_left),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          body: Container(color: Colors.white, child: noteList),
          bottomNavigationBar: Container(
            color: Theme.of(context).bottomAppBarColor,
            child: SafeArea(
              top: false,
              child: BottomAppBar(
                elevation: 0,
                child: Row(children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: _bottomHeight,
                      child: RawMaterialButton(
                          elevation: 0,
                          child: Image.asset(
                            'assets/images/cancel.png',
                            width: _bottomIconWidth,
                          ),
                          fillColor: _light,
                          onPressed: () => Navigator.pop(context)),
                    ),
                  ), // 取消按鈕
                  Expanded(
                    child: SizedBox(
                      height: _bottomHeight,
                      child: RawMaterialButton(
                          elevation: 0,
                          child: Image.asset(
                            'assets/images/confirm.png',
                            width: _bottomIconWidth,
                          ),
                          fillColor: _color,
                          onPressed: () async {
                            if (await _submitShare(noteNum) != true) {
                              Navigator.pop(context);
                            }
                          }),
                    ),
                  )
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
