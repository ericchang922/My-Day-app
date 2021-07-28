import 'dart:convert';

import 'package:My_Day_app/group/customer_check_box.dart';
import 'package:My_Day_app/models/note_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShareNotePage extends StatefulWidget {
  int groupNum;
  ShareNotePage(this.groupNum);

  @override
  _ShareNoteWidget createState() => new _ShareNoteWidget(groupNum);
}

class _ShareNoteWidget extends State<ShareNotePage> {
  int groupNum;
  _ShareNoteWidget(this.groupNum);

  NoteListModel _shareNoteModel = null;

  List _noteCheck = [];

  bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _shareNoteRequest();
    _buttonIsOnpressed();
  }

  _buttonIsOnpressed() {
    int count = 0;
    for (int i = 0; i < _noteCheck.length; i++) {
      if (_noteCheck[i] == true) {
        count++;
      }
    }
    if (count != 0) {
      setState(() {
        _isEnabled = true;
      });
    } else {
      setState(() {
        _isEnabled = false;
      });
    }
  }

  Future<void> _shareNoteRequest() async {
    var jsonString = await rootBundle.loadString('assets/json/note_list.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_end_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var shareStudyPlanModel = NoteListModel.fromJson(jsonMap);
    setState(() {
      _shareNoteModel = shareStudyPlanModel;
      for (int i = 0; i < _shareNoteModel.note.length; i++) {
        _noteCheck.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('選擇筆記',
                  style: TextStyle(fontSize: screenSize.width * 0.052)),
              leading: Container(
                margin: EdgeInsets.only(left: screenSize.height * 0.02),
                child: GestureDetector(
                  child: Icon(Icons.chevron_left),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(child: _buildShareNoteList(context)),
                _buildCheckButtom(context)
              ],
            )));
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

  Widget _buildShareNoteList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_shareNoteModel != null) {
      if (_shareNoteModel.note.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何共同筆記!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return ListView.separated(
            itemCount: _shareNoteModel.note.length,
            itemBuilder: (BuildContext context, int index) {
              var note = _shareNoteModel.note[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.height * 0.03,
                    vertical: screenSize.height * 0.008),
                title: Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.01),
                  child: Text(note.title,
                      style: TextStyle(fontSize: screenSize.width * 0.052)),
                ),
                trailing: CustomerCheckBox(
                  value: _noteCheck[index],
                  onTap: (value) {
                    if (value == true) {
                      if (_noteCount() == 0) {
                        _noteCheck[index] = value;
                      }
                    } else {
                      _noteCheck[index] = value;
                    }
                    _buttonIsOnpressed();
                  },
                ),
                onTap: () {
                  setState(() {
                    if (_noteCheck[index] == false) {
                      _noteCheck[index] = true;
                    } else {
                      _noteCheck[index] = false;
                    }
                  });
                  _buttonIsOnpressed();
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
      return Center(child: CircularProgressIndicator());
    }
  }

  Widget _buildCheckButtom(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var _onPressed;
    if (_isEnabled == true) {
      _onPressed = () {
        int index = _noteCheck.indexOf(true);
        print(_shareNoteModel.note[index].noteNum);
      };
    }
    return Row(children: <Widget>[
      Expanded(
        // ignore: deprecated_member_use
        child: FlatButton(
          height: screenSize.height * 0.07,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Image.asset(
            'assets/images/cancel.png',
            width: screenSize.width * 0.05,
          ),
          color: Theme.of(context).primaryColorLight,
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      Expanded(
          // ignore: deprecated_member_use
          child: Builder(builder: (context) {
        return FlatButton(
            disabledColor: Color(0xffCCCCCC),
            height: screenSize.height * 0.07,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Image.asset(
              'assets/images/confirm.png',
              width: screenSize.width * 0.05,
            ),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            onPressed: _onPressed);
      }))
    ]);
  }
}
