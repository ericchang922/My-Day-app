import 'package:My_Day_app/models/group/common_schedule_list_model.dart';
import 'package:My_Day_app/schedule/schedule_table.dart';
import 'package:My_Day_app/setting/settings.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:My_Day_app/schedule/create_schedule.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  double _fabDimension = 56.0;
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Scaffold(
      body: HomePageBody(),
      floatingActionButton: OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        openBuilder: (BuildContext context, VoidCallback _) {
          return CreateSchedule();
        },
        closedElevation: 6.0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(_fabDimension / 2)),
        ),
        closedColor: color,
        closedBuilder: (BuildContext context, VoidCallback openContainer) {
          return SizedBox(
            height: _fabDimension,
            width: _fabDimension,
            child: Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}

AppBar homePageAppBar(context) {
  Color color = Theme.of(context).primaryColor;
  return AppBar(title: Text('首頁'), backgroundColor: color, actions: [
    IconButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsPage()));
      },
      icon: Icon(Icons.settings),
    ),
  ]);
}

class HomePageBody extends StatefulWidget {
  @override
  State<HomePageBody> createState() => _HomePageBody();
}

class _HomePageBody extends State<HomePageBody> {
  int homeIndex = 1;
  PageController pageController;
  List<Widget> pageList = [
    ScheduleTable(sectionList: [
      {'start': '08:10', 'end': '09:00'},
      {'start': '09:10', 'end': '10:00'},
      {'start': '10:10', 'end': '11:00'},
      {'start': '11:10', 'end': '12:00'},
      {'start': '13:30', 'end': '14:20'},
      {'start': '14:25', 'end': '15:15'},
      {'start': '15:25', 'end': '16:15'},
    ])
  ];
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: homeIndex);
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: pageList,
    );
  }
}
