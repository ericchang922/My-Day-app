import 'package:My_Day_app/friend/friend_home_schedule/schedule_button.dart';
import 'package:My_Day_app/models/schedule/schedule_list_model.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:flutter/material.dart';
import 'package:My_Day_app/friend/friend_home_schedule/schedule_table_function.dart';

class TimetableTemplate {
  // 課表模板
  Color _tableBorderColor = Color(0xffE3E3E3); // 匡線顏色
  Color _weekDayColor = Color(0xffF6F6F6); // 星期的底色(灰)
  Map<String, int> _tableTypes = {
    'home_page': 1,
    'create': 2,
    'edit': 3,
    'view': 4
  };

  BuildContext context;
  String type;
  List timeLineList; //節次時間列表
  TableSchedule tableSchedule;
  List<List<String>> sectionDataList; // 課程資料
  List sectionNumList = []; // 節次紀錄(搭配sectionDataList)

  // tableSchedule
  ScheduleGetList _scheduleList;
  List _dayList;
  List<DateTime> _dateList;
  DateTime _monday;

  int _typeId; // 課表用途類型(_tableTypes)

  // size
  Sizing _sizing;
  double _allDayRowHeight;
  FixedColumnWidth _tableWidth;
  Map<int, TableColumnWidth> _columnWidths; // table 總寬度
  double _tableContentHeight = 0; //表格總高度

  Create _create;
  ScheduleButton scheduleButton;

  List<TableRow> _tbodyChildrenWidget;

  TimetableTemplate(
      {this.context,
      this.type,
      this.timeLineList,
      this.sectionDataList,
      this.sectionNumList,
      this.tableSchedule}) {
    _sizing = Sizing(context);
    _typeId = _tableTypes[type];
    _allDayRowHeight = _sizing.height(3);
    _tableWidth = FixedColumnWidth(_sizing.width(100) / 8);

    _create = Create(context: context);

    _columnWidths = {
      0: _tableWidth,
      1: _tableWidth,
      2: _tableWidth,
      3: _tableWidth,
      4: _tableWidth,
      5: _tableWidth,
      6: _tableWidth
    };

    _scheduleList = tableSchedule.scheduleList;
    _dayList = tableSchedule.dayList;
    _dateList = tableSchedule.dateList;
    _monday = tableSchedule.monday;

    _tbodyChildrenWidget = _tbodyChildren();

    if (_typeId == 1) {
      scheduleButton = ScheduleButton(
          context: context,
          scheduleList: _scheduleList,
          monday: _monday,
          timeLineList: timeLineList);
    }
  }

  // 建立表身 ---------------------------------------------------------------------------------------
  List<TableRow> _tbodyChildren() {
    // 表格內容整理（格數、時間、科目）
    List<TableRow> _children = []; // 表格橫列的內容(要回傳得值)
    Map<String, String> section; // 現在的時間區段 {'start': 'XX:XX', 'end': 'XX:XX'}
    List<Widget> _contents; // 每一格裡面的內容

    for (int i = 0; i < timeLineList.length; i++) {
      section = timeLineList[i]; // 時間區段
      String _start = section['start']; // 區段開始
      String _end = section['end']; // 區段結束
      String _nextStart; // 下一段時間的開始

      double _timeHeight = timeHeight(_start, _end, _sizing.height(100));
      // 這段時間的高度
      _tableContentHeight += _timeHeight; // 累計表格總高度

      // 整理課程 List --------------------------------------------------------------------------------
      List<String> sectionSubject = [null, null, null, null, null, null, null];
      if (sectionDataList.length > 0) {
        // 如果有課程
        if (sectionNumList.indexOf(i + 1) < 0) {
          // 如果在記錄節次的 List 中不存在(<0 表示這節沒有課)
          sectionSubject = [null, null, null, null, null, null, null];
          // 所以就全部設為 null
        } else {
          sectionSubject = sectionDataList[sectionNumList.indexOf(i + 1)];
          // 不然就在課程資料裡面找到相對應的課程
        }
      }

      // 填入資料 -------------------------------------------------------------------------------------
      _contents = [_create.time(_start, _end)]; // 橫列左側時間

      for (int j = 0; j < 7; j++) {
        _contents.add(_create.subject(sectionSubject[j], _timeHeight));
        // 將上面的課程 List 加入表格中，如果有課就會填入科目，如果每有課 List 中的資料會是 null 因此也不會顯示課程
      }

      _children.add(TableRow(children: _contents)); // 做完七次之後(一列有七天)裝入 TableRow

      // 自動加入間隔 -----------------------------------------------------------------------------------
      if (i + 1 < timeLineList.length) {
        // 確認下一個開始沒有超出 List 的範圍
        _nextStart = timeLineList[i + 1]['start'];
      }
      if (_nextStart != null) {
        double space = timeHeight(_end, _nextStart, _sizing.height(100));
        // 取得此行程和下一個行程之間的間隔（以小時計算）

        if (space >= _sizing.height(7)) {
          // 大於一小時則會在中間加入空格
          timeLineList.insert(i + 1, {'start': '', 'end': ''});
          i++;
          _tableContentHeight += space; // 將空格的高度加入表格總高度

          _contents = [
            Container(
              color: _weekDayColor,
              height: space,
            )
          ]; // 空格列最左側為灰色

          for (int j = 0; j < 7; j++) {
            _contents.add(Container(height: space));
            // 整列共有七格為空白
          }
          _children.add(TableRow(children: _contents));
        }
      }
    }

    return _children;
  }

  // Thead ----------------------------------------------------------------------------------------
  Container thead() {
    double _theadHeight;
    TableRow _topRow;
    TableRow _allDay;

    if (_typeId == 1) {
      _theadHeight = _sizing.height(7) + _allDayRowHeight;

      _topRow = TableRow(children: [
        _create.top(''),
        _create.top(_dayList[0]),
        _create.top(_dayList[1]),
        _create.top(_dayList[2]),
        _create.top(_dayList[3]),
        _create.top(_dayList[4]),
        _create.top(_dayList[5]),
        _create.top(_dayList[6])
      ]);
      _allDay = TableRow(children: scheduleButton.getAllDay());
    } else {
      _theadHeight = _sizing.height(5);
      _topRow = null;
      _allDay = null;
    }

    return Container(
      height: _theadHeight,
      width: _sizing.width(100),
      child: Table(
        columnWidths: _columnWidths,
        border: TableBorder.all(
            color: _tableBorderColor, width: 1, style: BorderStyle.solid),
        children: [
          _topRow,
          TableRow(children: [
            _create.weekDay(''),
            _create.weekDay('一'),
            _create.weekDay('二'),
            _create.weekDay('三'),
            _create.weekDay('四'),
            _create.weekDay('五'),
            _create.weekDay('六'),
            _create.weekDay('日'),
          ]),
          _allDay
        ],
      ),
    );
  }

  // Tbody ----------------------------------------------------------------------------------------
  Container tbody() {
    return Container(
      child: ListView(
        children: [
          Stack(
              alignment: Alignment.topLeft,
              children: [
                Table(
                  columnWidths: _columnWidths,
                  border: TableBorder.all(
                      color: _tableBorderColor,
                      width: 1,
                      style: BorderStyle.solid),
                  children: _tbodyChildrenWidget,
                ),
                Positioned(
                    left: _sizing.width(100) / 8,
                    child: Row(
                        children: (() {
                      if (_typeId == 1) {
                        return _create.dateBtn(
                            _dateList, _tableContentHeight, _scheduleList);
                      }
                    }())))
              ]..addAll(() {
                  if (_typeId == 1) {
                    return scheduleButton.getSchedules();
                  }
                }()))
        ],
      ),
    );
  }
}

class TableSchedule {
  ScheduleGetList scheduleList;
  DateTime monday;

  List dayList = [];
  List<DateTime> dateList = [];

  TableSchedule({this.monday, this.scheduleList}) {
    for (int i = 0; i < 7; i++) {
      DateTime days = monday.add(Duration(days: i));
      dateList.add(days);
      dayList.add((days.day).toString());
    }
  }
}
