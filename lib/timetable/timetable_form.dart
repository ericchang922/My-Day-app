import 'package:flutter/material.dart';

const PrimaryColor = const Color(0xFFF86D67);

class TimetableFormPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimetableForm();
  }
}

class TimetableForm extends State {
  String dropdownValueSemester = 'One';
  String dropdownValueSchool = 'One';
  String dropdownValueYear = 'One';
  get child => null;
  get left => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF86D67),
        title: Text('新增課表', style: TextStyle(fontSize: 20)),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children:[
          Padding(
            padding: EdgeInsets.fromLTRB(42, 106, 0, 0),
            child: Text(
              '學校：',
              style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 1, 0, 0),
            child: DropdownButton(
              hint: Text(' ',
                  style: TextStyle(fontSize: 18),),
              value: dropdownValueSchool,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(),      
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueSchool = newValue;
                });
              },    
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 60, 0, 0),
            child: Text(
              '學年：',
              style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 1, 0, 0),
            child: DropdownButton(
              hint: Text(' ',
                  style: TextStyle(fontSize: 18),),
              value: dropdownValueYear,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(),      
              items: <String>['One', 'Two', 'Free', 'Four']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueYear = newValue;
                });
              },    
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 60, 0, 0),
            child: Text(
              '學期：',
              style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 1, 0, 0),
            child: DropdownButton(
              hint: Text(' ',
                  style: TextStyle(fontSize: 18),),
              value: dropdownValueSemester,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: const TextStyle(color: Colors.black),
              underline: Container(),      
              items: <String>['One', 'Two']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValueSemester = newValue;
                });
              },    
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 60, 0, 0),
            child: Text(
              '學校開始日期：',
              style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 1, 0, 0),
            child: RaisedButton(
              onPressed: ()  async {
                var result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(2020), 
                  lastDate: DateTime(2025));
                print('$result');
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 60, 0, 0),
            child: Text(
              '學校結束日期：',
              style: TextStyle(fontSize: 18),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(42, 1, 0, 0),
            child: RaisedButton(
              onPressed: ()  async {
                var result = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(), 
                  firstDate: DateTime(2020), 
                  lastDate: DateTime(2025));
                print('$result');
              },
            ),
          ),
        ],
      ),
    );
  }
}
