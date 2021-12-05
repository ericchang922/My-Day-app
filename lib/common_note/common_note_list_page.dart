import 'package:flutter/material.dart';

import 'package:My_Day_app/main.dart';
import 'package:My_Day_app/common_note/common_note_detail_page.dart';
import 'package:My_Day_app/common_note/share_note_page.dart';
import 'package:My_Day_app/models/note/share_note_list_model.dart';
import 'package:My_Day_app/public/note_request/cancel_share.dart';
import 'package:My_Day_app/public/note_request/get_group_list.dart';
import 'package:My_Day_app/public/loadUid.dart';
import 'package:My_Day_app/public/sizing.dart';

class CommonNoteListPage extends StatefulWidget {
  int groupNum;
  CommonNoteListPage(this.groupNum);

  @override
  _CommonNoteListWidget createState() => new _CommonNoteListWidget(groupNum);
}

class _CommonNoteListWidget extends State<CommonNoteListPage> with RouteAware {
  String uid;
  _uid() async {
    String id = await loadUid();
    setState(() => uid = id);

    await _groupNoteListRequest();
  }

  int groupNum;
  _CommonNoteListWidget(this.groupNum);

  ShareNoteListModel _shareNoteListModel;

  @override
  void initState() {
    super.initState();
    _uid();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    _groupNoteListRequest();
  }

  _groupNoteListRequest() async {
    ShareNoteListModel _request =
        await GetGroupList(context: context, uid: uid, groupNum: groupNum)
            .getData();

    setState(() {
      _shareNoteListModel = _request;
    });
  }

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);

    double _leadingL = _sizing.height(2);

    double _titleSize = _sizing.height(2.5);
    double _subtitleSize = _sizing.height(2);
    double _appBarSize = _sizing.width(5.2);

    Color _color = Theme.of(context).primaryColor;

    Widget noNote = Center(child: Text('目前沒有任何共同筆記!'));
    Widget groupNoteList;

    _submitCancel(int noteNum) async {
      var submitWidget;
      _submitWidgetfunc() async {
        return CancelShare(uid: uid, noteNum: noteNum);
      }

      submitWidget = await _submitWidgetfunc();
      if (await submitWidget.getIsError())
        return true;
      else
        return false;
    }

    _popupMenu(String id, int noteNum) {
      if (id == uid) {
        return PopupMenuButton(
          offset: Offset(-40, 0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizing.height(1))),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                value: 1,
                child: Container(
                    alignment: Alignment.center,
                    child: Text("取消分享",
                        style: TextStyle(fontSize: _subtitleSize))),
              ),
            ];
          },
          onSelected: (int value) async {
            if (await _submitCancel(noteNum) != true) {
              _groupNoteListRequest();
            }
          },
        );
      }
    }

    if (_shareNoteListModel != null) {
      if (_shareNoteListModel.note.length == 0) {
        groupNoteList = noNote;
      } else {
        groupNoteList = ListView.separated(
            itemCount: _shareNoteListModel.note.length,
            itemBuilder: (BuildContext context, int index) {
              var note = _shareNoteListModel.note[index];
              return ListTile(
                contentPadding: EdgeInsets.symmetric(
                    horizontal: _sizing.height(1),
                    vertical: _sizing.height(0.8)),
                title: Container(
                  margin: EdgeInsets.only(left: _sizing.height(3)),
                  child:
                      Text(note.title, style: TextStyle(fontSize: _titleSize)),
                ),
                trailing: _popupMenu(note.createId, note.noteNum),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CommonNoteDetailPage(note.noteNum)));
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
      groupNoteList = Container(
          color: Colors.white,
          child: Center(child: CircularProgressIndicator()));
    }

    return Container(
      color: _color,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: _color,
              title: Text('共同筆記', style: TextStyle(fontSize: _appBarSize)),
              leading: Container(
                margin: EdgeInsets.only(left: _leadingL),
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
                          builder: (context) => ShareNotePage(groupNum)));
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            body: Container(
                color: Colors.white,
                child: SafeArea(top: false, child: groupNoteList))),
      ),
    );
  }
}
