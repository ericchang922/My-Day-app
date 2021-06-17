import 'package:flutter/material.dart';

class GroupAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GroupAddWidget(),
    );
  }
}

class GroupAddWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xffF86D67),
          title: Text('建立群組', style: TextStyle(fontSize: 22)),
        ),
        body: _GroupAdd());
  }
}

class _GroupAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('建立群組'),
    );

    // return Container(
    //   child: Row(
    //     children: <Widget>[
    //       Text('群組名稱：'),
    //       Container(
    //         width: 100,
    //         height: 40,
    //         child: TextField(
    //         decoration: InputDecoration(
    //           fillColor: Color(0xfff3f3f4),
    //           filled: true,
    //           border: OutlineInputBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(10)),
    //             borderSide: BorderSide(
    //               color: Color(0xfff3f3f4),
    //               width: 2.0,
    //             )
    //           )
    //         ),
    //       ),
    //       )

    //     ],

    // ),
    // margin: EdgeInsets.all(10),);
  }
}
