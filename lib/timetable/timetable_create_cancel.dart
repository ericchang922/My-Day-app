import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

Future<bool> timetableCreateCancel(BuildContext context) async {
  Sizing _sizing = Sizing(context);

  double _borderRadius = _sizing.height(3);
  double _inkwellH = _sizing.height(6);

  double _pSize = _sizing.height(2.3);
  double _subtitleSize = _sizing.height(2);

  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          contentPadding: EdgeInsets.only(top: _sizing.height(2)),
          content: Container(
            width: _sizing.width(20),
            height: _sizing.height(15),
            child: (Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: _sizing.height(2)),
                    child: Text(
                      "是否放棄新增此課表",
                      style: TextStyle(fontSize: _pSize),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: _inkwellH,
                          padding: EdgeInsets.only(
                              top: _sizing.height(1.5),
                              bottom: _sizing.height(1.5)),
                          decoration: BoxDecoration(
                            color: _light,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(_borderRadius),
                            ),
                          ),
                          child: Text(
                            "否",
                            style: TextStyle(
                                fontSize: _subtitleSize, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: _inkwellH,
                          padding: EdgeInsets.only(
                              top: _sizing.height(1.5),
                              bottom: _sizing.height(1.5)),
                          decoration: BoxDecoration(
                            color: _color,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(_borderRadius)),
                          ),
                          child: Text(
                            "是",
                            style: TextStyle(
                                fontSize: _subtitleSize, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                ),
              ],
            )),
          ),
        );
      });
}
