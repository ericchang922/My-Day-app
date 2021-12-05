// flutter
import 'package:flutter/material.dart';
// therd
import 'package:animations/animations.dart';
// my day
import 'package:My_Day_app/home/home_Update.dart';
import 'package:My_Day_app/friend/friend_home_page.dart';
import 'package:My_Day_app/public/sizing.dart';

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
    Sizing _sizing = Sizing(context);
    double iconSize = _sizing.height(4);

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
