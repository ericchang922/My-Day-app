import 'dart:convert';

import 'package:My_Day_app/common_note/share_note_page.dart';
import 'package:My_Day_app/models/note_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonNoteListPage extends StatefulWidget {
  int groupNum;
  CommonNoteListPage(this.groupNum);

  @override
  _CommonNoteListWidget createState() => new _CommonNoteListWidget(groupNum);
}

class _CommonNoteListWidget extends State<CommonNoteListPage> {
  int groupNum;
  _CommonNoteListWidget(this.groupNum);

  NoteListModel _groupNoteListModel = null;

  @override
  void initState() {
    super.initState();
    _groupNoteListtRequest();
  }

  Future<void> _groupNoteListtRequest() async {
    var jsonString =
        await rootBundle.loadString('assets/json/note_list.json');

    // var httpClient = HttpClient();
    // var request = await httpClient.getUrl(Uri.http('myday.sytes.net',
    //     '/vote/get_end_list/', {'uid': uid, 'groupNum': groupNum.toString()}));
    // var response = await request.close();
    // var jsonString = await response.transform(utf8.decoder).join();
    // httpClient.close();

    var jsonMap = json.decode(jsonString);

    var groupNoteListModel = NoteListModel.fromJson(jsonMap);
    setState(() {
      _groupNoteListModel = groupNoteListModel;
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
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('共同筆記',
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
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ShareNotePage(groupNum)));
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          body: Container(color: Colors.white, child: _buildGroupNoteList(context))),
    );
  }

  Widget _buildGroupNoteList(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    if (_groupNoteListModel != null) {
      if (_groupNoteListModel.note.length == 0) {
        return Container(
          alignment: Alignment.center,
          child: Text('目前沒有任何共同筆記!',
              style: TextStyle(fontSize: screenSize.width * 0.03)),
        );
      } else {
        return ListView.separated(
            itemCount: _groupNoteListModel.note.length,
            itemBuilder: (BuildContext context, int index) {
              var note = _groupNoteListModel.note[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: screenSize.height * 0.01,
                    vertical: screenSize.height * 0.008),
                title: Container(
                  margin: EdgeInsets.only(left: screenSize.height * 0.03),
                  child: Text(note.title,
                      style: TextStyle(fontSize: screenSize.width * 0.052)),
                ),
                trailing: PopupMenuButton(
                  offset: Offset(-40, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenSize.height * 0.01)),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        value: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text("取消分享",
                                style: TextStyle(
                                    fontSize: screenSize.width * 0.035))),
                      ),
                    ];
                  },
                  onSelected: (int value) {
                    print(note.noteNum);
                  },
                ),
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
}
