import 'package:My_Day_app/public/note_request/not_share_list.dart';
import 'package:flutter/material.dart';

import 'package:My_Day_app/public/alert.dart';
import 'package:My_Day_app/public/note_request/share.dart';
import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/note/note_list_model.dart';

class ShareNotePage extends StatefulWidget {
  int groupNum;
  ShareNotePage(this.groupNum);

  @override
  _ShareNoteWidget createState() => new _ShareNoteWidget(groupNum);
}

class _ShareNoteWidget extends State<ShareNotePage> {
  int groupNum;
  _ShareNoteWidget(this.groupNum);

  NoteListModel _noteListModel;

  String uid = 'lili123';
  int noteNum;

  List _noteCheck = [];

  @override
  void initState() {
    super.initState();
    _noteListRequest();
  }

  _noteListRequest() async {
    // var response =
    //     await rootBundle.loadString('assets/json/share_note_list.json');
    // var responseBody = json.decode(response);
    // var groupNoteListModel = ShareNoteListModel.fromJson(responseBody);

    NoteListModel _request = await NotShareList(uid: uid).getData();

    setState(() {
      _noteListModel = _request;
      for (int i = 0; i < _noteListModel.note.length; i++) {
        _noteCheck.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double _height = size.height;
    double _width = size.width;

    double _leadingL = _height * 0.02;
    double _bottomHeight = _height * 0.07;
    double _bottomIconWidth = _width * 0.05;

    double _titleSize = _height * 0.025;
    double _appBarSize = _width * 0.052;

    Color _color = Theme.of(context).primaryColor;
    Color _light = Theme.of(context).primaryColorLight;

    Widget noNote = Center(child: Text('目前沒有任何筆記!'));
    Widget noteList;

    _submitShare(int noteNum) async {
      String _alertTitle = '分享筆記失敗';
      if (noteNum == null) {
        await alert(context, _alertTitle, '請選擇一個要分享的筆記');
        return true;
      } else {
        var submitWidget;
        _submitWidgetfunc() async {
          return Share(uid: uid, noteNum: noteNum, groupNum: groupNum);
        }

        submitWidget = await _submitWidgetfunc();
        if (await submitWidget.getIsError())
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

    if (_noteListModel != null) {
      if (_noteListModel.note.length == 0) {
        noteList = noNote;
      } else {
        noteList = ListView.separated(
            itemCount: _noteListModel.note.length,
            itemBuilder: (BuildContext context, int index) {
              var note = _noteListModel.note[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _height * 0.03, vertical: _height * 0.008),
                title: Container(
                  margin: EdgeInsets.only(left: _height * 0.01),
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
