import 'package:flutter/material.dart';

class HomeUpdate extends StatefulWidget {
  final Widget child;
  HomeUpdate({Key key, @required this.child}) : super(key: key);

  State<HomeUpdate> createState() => _HomeUpdate();
}

class _HomeUpdate extends State<HomeUpdate> {
  DateTime nowMon = DateTime.now();
  int weekCount= 0;
  String selectedScheduleType = 'all';

  void updateDate(DateTime mon) {
    setState(() => nowMon = mon);
  }

  void updateWeek(int week){
    setState(() => weekCount = week);
  }

  void updateSelected(String value){
    setState(()=>selectedScheduleType = value);
  }


  @override
  Widget build(BuildContext context) => HomeInherited(
        child: widget.child,
        nowMon: nowMon,
        weekCount: weekCount,
        selectedScheduleType: selectedScheduleType,
        homeUpdate: this,
      );
}

class HomeInherited extends InheritedWidget {
  final DateTime nowMon;
  final _HomeUpdate homeUpdate;
  final int weekCount;
  final String selectedScheduleType;

  HomeInherited({
    Key key,
    @required this.nowMon,
    @required Widget child,
    @required this.weekCount,
    @required this.homeUpdate,
    @required this.selectedScheduleType
  }) : super(key: key, child: child);

  static _HomeUpdate of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<HomeInherited>().homeUpdate;

  @override
  bool updateShouldNotify(HomeInherited old) => nowMon != old.nowMon;
}
