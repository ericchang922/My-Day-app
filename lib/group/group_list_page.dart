import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'group_create_page.dart';
import 'group_join_page.dart';

class GroupListPage extends StatelessWidget {
  String g;
  GroupListPage(String g) {
    this.g = g;
  }

  selectedItem(BuildContext context, item) async {
    switch (item) {
      case 0:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => GroupCreatePage()));
        break;
      case 1:
        bool action = await groupJoinDialog(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(g, style: TextStyle(fontSize: 22)),
          actions: [
            PopupMenuButton<int>(
              offset: Offset(50, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              icon: Icon(Icons.add),
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text("建立群組")),
                PopupMenuDivider(
                  height: 1,
                ),
                PopupMenuItem<int>(value: 1, child: Text("加入群組")),
              ],
              onSelected: (item) => selectedItem(context, item),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Container(
              color: Colors.white,
              child: GroupListWidget()
            ),
          )
        ));
  }
}

class GroupListWidget extends StatefulWidget {
  @override
  _GroupListState createState() => new _GroupListState();
}

class _GroupListState extends State<GroupListWidget> {
  // String _responseBody;
  // Future<void>getGroupList() async {
  //   String uid = 'lili123';
  //   var httpClient = HttpClient();
  //   var request = await httpClient
  //       .getUrl(Uri.http('localhost:8000', '/group/group_list/', {'uid': uid}));
  //   var response = await request.close();
  //   var responseBody = await response.transform(utf8.decoder).join();
  //   print(responseBody);
  //   httpClient.close();

  //   setState(() {
  //     _responseBody = responseBody;
  //   });
  // }
  // List <GroupModel> groupList = [];

  // getGroupRequest() async {
  //   var reponse = await rootBundle.loadString('assets/json/groups.json');

  //   String jsonBody = json.decode(reponse);
  // }

  // @override
  // void initState() {
  //   getGroupRequest();
  // }

  @override
  Widget build(BuildContext context) {
    String jsonData =
        '[{"groupID": 1,"title":"學生會","typeId":1,"peopleCount":10},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3},{"groupID": 2,"title":"吃晚餐","typeId":2,"peopleCount":3}]';
    List groupList = json.decode(jsonData);
    List typeColor = <int>[
      0xffF78787,
      0xffFFD51B,
      0xffFFA800,
      0xffB6EB3A,
      0xff53DAF0,
      0xff4968BA,
      0xffCE85E4
    ];

    return ListView.builder(
      itemCount: groupList.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
            margin: EdgeInsets.only(
              top: 5,
              left: 5,
            ),
            child: Column(
              children: [
                ListTile(
                  onTap: () {},
                  title: Text(
                    '${groupList[index]["title"]} (${groupList[index]["peopleCount"]})',
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Container(
                    child: CircleAvatar(
                      radius: 20.0,
                      backgroundColor:
                          Color(typeColor[groupList[index]["typeId"]]),
                    ),
                  ),
                ),
                Divider(),
              ],
            ));
      },
    );
  }
}
