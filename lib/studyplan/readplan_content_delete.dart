import 'package:flutter/material.dart';

Future<bool> readplanDeleteDialog(BuildContext context) async {
  
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
            width: screenSize.width * 0.1,
            height: screenSize.height * 0.15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: <Widget>[
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                   
                        children: <Widget>[
                          Text(
                            "是否刪除此讀書計畫",
                            style:
                                TextStyle(fontSize: screenSize.width * 0.06),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )),
                   
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
                            "否",
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
                            "是",
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
