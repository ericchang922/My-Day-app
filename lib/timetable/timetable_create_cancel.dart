import 'package:flutter/material.dart';

Future<bool> timetableCreateCancel(BuildContext context) async {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _height = size.height;

  double _borderRadius = _height * 0.03;
  double _inkwellH = _height * 0.06;

  double _pSize = _height * 0.023;
  double _subtitleSize = _height * 0.02;

  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          contentPadding: EdgeInsets.only(top: _height * 0.02),
          content: Container(
            width: _width * 0.2,
            height: _height * 0.15,
            child: (Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: _height * 0.02),
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
                              top: _height * 0.015, bottom: _height * 0.015),
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
                              top: _height * 0.015, bottom: _height * 0.015),
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
