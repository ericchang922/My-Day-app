import 'package:flutter/material.dart';

Future<bool> readplanAddDialog(BuildContext context) async {
  final _groupIDController = TextEditingController();
  String _inputGroupID = '';

  return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        var screenSize = MediaQuery.of(context).size;
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(screenSize.height * 0.03))),
          contentPadding: EdgeInsets.only(top: screenSize.height * 0.02),
          content: Container(
            width: screenSize.width * 0.2,
            height: screenSize.height * 0.2459,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            "編輯備註",
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Container(
                          height: screenSize.height * 0.1,
                          margin: EdgeInsets.only(
                            top:screenSize.height * 0.0184,
                            left: screenSize.height * 0.02,
                            right: screenSize.height * 0.02,
                            bottom: screenSize.height * 0.0384,
                          ),
                          child: new TextField(
                            keyboardType: TextInputType.multiline,
                            style:
                                TextStyle(fontSize: screenSize.width * 0.041),
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: screenSize.height * 0.02,
                                    vertical: screenSize.height * 0.041),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.height * 0.01)),
                                  borderSide: BorderSide(
                                    color: Color(0xff070707),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          screenSize.height * 0.01)),
                                  borderSide:
                                      BorderSide(color: Color(0xff7AAAD8)),
                                )),
                            controller: _groupIDController,
                            onChanged: (text) {
                              _inputGroupID = _groupIDController.text;
                            },
                          )),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Container(
                          height: screenSize.height * 0.06,
                          padding: EdgeInsets.only(
                              top: screenSize.height * 0.015,
                              bottom: screenSize.height * 0.015),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColorLight,
                            borderRadius: BorderRadius.only(
                              bottomLeft:
                                  Radius.circular(screenSize.height * 0.03),
                            ),
                          ),
                          child: Text(
                            "取消",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.white),
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
                          height: screenSize.height * 0.06,
                          padding: EdgeInsets.only(
                              top: screenSize.height * 0.015,
                              bottom: screenSize.height * 0.015),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(screenSize.height * 0.03)),
                          ),
                          child: Text(
                            "確認",
                            style: TextStyle(
                                fontSize: screenSize.width * 0.035,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        onTap: () {
                          print(_inputGroupID);
                          Navigator.of(context).pop(true);
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      });
}
