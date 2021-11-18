import 'package:flutter/material.dart';
import 'dart:async';


// 

class FriendsPrivacySettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FriendsPrivacySettings();
  }
}
class FriendsPrivacySettings extends State {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: block.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot) {
        switchValue = snapshot.data;
        return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('好友隱私設定', style: TextStyle(fontSize: 20)),
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 15, left: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text.rich(TextSpan(
                      children: <InlineSpan>[
                        WidgetSpan(
                          child: new Image.asset(
                            "assets/images/search.png",
                            width: 20,
                          ),
                        ),
                        TextSpan(
                          text: 'xxxxxx',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<int>(
                    offset: Offset(0, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text(
                                  '玩聚邀請',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                          ),
                          trailing: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                              return Switch(        
                                value: switchValue,
                                onChanged: (newValue) {
                                  block.changeTheme1(newValue);
                                  print(switchValue);
                                  setState(() {});
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Color(0xffF86D67),
                                // inactiveThumbColor: Color(0xffF86D67),
                                // inactiveTrackColor: Color(0xffF86D67),
                            );}
                          ),
                        ),
                      ),
                      PopupMenuDivider(
                        height: 1,
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: ListTile(
                          title: Text(
                                  '公開課表',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                          ),
                          trailing: StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                              return Switch(        
                                value: switchValue,
                                onChanged: (newValue) {
                                  block.changeTheme1(newValue);
                                  print(switchValue);
                                  setState(() {});
                                },
                                activeColor: Colors.white,
                                activeTrackColor: Color(0xffF86D67),
                                // inactiveThumbColor: Color(0xffF86D67),
                                // inactiveTrackColor: Color(0xffF86D67),
                            );}
                          ),
                        ),
                      ),
                    ]),
                  ]),
          ),
            
             
          
          Container(
            margin: EdgeInsets.only(top: 10),
            color: Color(0xffE3E3E3),
            constraints: BoxConstraints.expand(height: 1.0),
          ),
              // actions: <Widget>[
              //   PopupMenuButton(itemBuilder: (context) {
              //     return [
              //       PopupMenuItem(
              //           child: ListTile(
              //         title: Text("Dark Theme"),
              //         trailing: StatefulBuilder(builder:
              //             (BuildContext context, StateSetter setState) {
              //           return Switch(
              //             value: switchValue,
              //             onChanged: (newValue) {
              //               block.changeTheme1(newValue);
              //               print(switchValue);
              //               setState(() {});
              //             },
              //           );
              //         }),
              //       )), //Problem
              //     ];
              //   })
              // ],
            ]),
          ),
        );
      },
    );
  }
}

class Block {
  final _themeContol = StreamController<bool>();

  void changeTheme1(bool value) {
    _themeContol.sink.add(value);
  }

  get darkThemeEnabled => _themeContol.stream;
}

final block = Block();
