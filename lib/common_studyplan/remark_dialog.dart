import 'package:flutter/material.dart';

Future<String> remarkDialog(BuildContext context, String remark) async {
  Size size = MediaQuery.of(context).size;
  double _width = size.width;
  double _height = size.height;

  double _borderRadius = _height * 0.03;
  double _textLBR = _height * 0.02;
  double _iconWidth = _width * 0.05;
  double _textFied = _height * 0.1;
  double _inkwellH = _height * 0.06;

  double _pSize = _height * 0.023;
  double _subtitleSize = _height * 0.02;

  Color _bule = Color(0xff7AAAD8);
  Color _textFiedBorder = Color(0xff707070);
  Color _color = Theme.of(context).primaryColor;
  Color _light = Theme.of(context).primaryColorLight;

  final _remarkController = TextEditingController();
  _remarkController.text = remark;

  String newRemark;

  return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
          contentPadding: EdgeInsets.only(top: _height * 0.02),
          content: Container(
            width: _width * 0.2,
            height: _height * 0.23,
            child: GestureDetector(
              // 點擊空白處釋放焦點
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Column(
                    children: [
                      Text(
                        "備註",
                        style: TextStyle(fontSize: _pSize),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: _textLBR,
                          left: _textLBR,
                          right: _textLBR,
                          bottom: _height * 0.01,
                        ),
                        height: _textFied,
                        child: TextField(
                          style: TextStyle(fontSize: _pSize),
                          maxLength: 30,
                          maxLines: null,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: _height * 0.01,
                                  vertical: _height * 0.01),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_height * 0.01)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_height * 0.01)),
                                borderSide: BorderSide(color: _bule),
                              )),
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: _remarkController.text,
                                  // 保持光標在最後
                                  selection: TextSelection.fromPosition(
                                      TextPosition(
                                          affinity: TextAffinity.downstream,
                                          offset:
                                              _remarkController.text.length)))),
                          onChanged: (text) => newRemark = text,
                        ),
                      )
                    ],
                  )),
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
                              "取消",
                              style: TextStyle(
                                  fontSize: _subtitleSize, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(remark);
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
                              "確認",
                              style: TextStyle(
                                  fontSize: _subtitleSize, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          onTap: () {
                            String value = newRemark == '' ? null : newRemark;
                            Navigator.of(context).pop(value);
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
