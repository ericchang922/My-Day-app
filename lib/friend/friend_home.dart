// flutter
import 'package:My_Day_app/friend/friend_home_page.dart';
import 'package:flutter/material.dart';
// therd
import 'package:animations/animations.dart';
// my day
import 'package:My_Day_app/home/home_Update.dart';

class FriendHome extends StatefulWidget {
  String friendId;
  FriendHome(this.friendId);
  @override
  State<FriendHome> createState() => _FriendHome(friendId);
}

class _FriendHome extends State<FriendHome> {
  String friendId;
  _FriendHome(this.friendId);
  int _index = 0;

  void _onTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime nowMon = HomeInherited.of(context).nowMon;
    int weekCount = HomeInherited.of(context).weekCount;
    final _appBars = <Widget>[
      FriendhomePageAppBar(context, nowMon, weekCount),
    ];
    Color color = Theme.of(context).primaryColor;
    var size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    double iconSize = height * 0.04;

    return Container(
      color: color,
      child: SafeArea(
          child: Scaffold(
        appBar: _appBars[_index],
        body: PageTransitionSwitcher(
          transitionBuilder: (Widget child, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return SharedAxisTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.vertical,
            );
          }, // 動畫 Widget function
          child: FriendHomePage(friendId),
        ),
      )),
      // ),
    );
  }
}
