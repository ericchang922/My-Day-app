import 'package:flutter/material.dart';

import 'package:My_Day_app/public/sizing.dart';

class CustomerCheckBox extends StatefulWidget {
  CustomerCheckBox({Key key, @required this.value, @required this.onTap})
      : super(key: key);

  final bool value;
  final onTap;
  @override
  State<StatefulWidget> createState() {
    return _CustomerCheckBox();
  }
}

class _CustomerCheckBox extends State<CustomerCheckBox> {
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    return InkWell(
      child: Container(
        width: _sizing.width(5),
        height: _sizing.width(5),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: widget.value
                    ? Theme.of(context).primaryColor
                    : Color(0xff999999)),
            color: widget.value ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(24)),
      ),
      onTap: () {
        widget.onTap(!widget.value);
      },
    );
  }
}
