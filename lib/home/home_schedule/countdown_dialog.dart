import 'package:flutter/material.dart';
import 'package:My_Day_app/public/sizing.dart';
import 'package:My_Day_app/models/schedule/countdown_list_model.dart';

Future<void> countdownDialog(
    BuildContext context, CountdownList countdownList) {
  Sizing _sizing = Sizing(context);

  List<Widget> showList = [];

  for (var s in countdownList.schedule) {
    showList.add(Container(
      width: _sizing.width(6),
      child: Padding(
        padding: EdgeInsets.all(_sizing.height(1)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            s.title,
            style: TextStyle(
                color: Colors.black,
                fontSize: _sizing.height(2.5),
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.normal),
            textAlign: TextAlign.left,
          ),
          Text('倒數 ${s.countdownDate.toString()} 天')
        ]),
      ),
    ));
  }

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_sizing.height(3)),
            ),
            child: Container(
              alignment: Alignment.centerLeft,
              height: _sizing.height(50),
              width: _sizing.width(70),
              child: Stack(children: [
                Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(
                            top: _sizing.height(3),
                            bottom: _sizing.height(3),
                            left: _sizing.width(5),
                            right: _sizing.width(5)),
                        child: Container(
                            height: _sizing.height(35),
                            child: ListView(children: showList)))
                  ],
                )
              ]),
            ));
      });
}
