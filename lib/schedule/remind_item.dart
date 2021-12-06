import 'package:My_Day_app/public/sizing.dart';
import 'package:flutter/material.dart';

class RemindItem extends StatefulWidget {
  List _list;
  RemindItem(this._list);
  @override
  _RemindItem createState() => _RemindItem(_list);
}

class _RemindItem extends State<RemindItem> {
  List _list;
  _RemindItem(this._list);

  @override
  Widget build(BuildContext context) {
    Sizing _sizing = Sizing(context);
    String _getTimeText(index) {
      String hourText =
          _list[index].inHours == 0 ? '' : '${_list[index].inHours} 小時';
      String minuteText =
          _list[index].inMinutes.remainder(60) == 0 && hourText != ''
              ? ''
              : '${_list[index].inMinutes.remainder(60)} 分鐘';
      return '$hourText $minuteText 前';
    }

    double _size = _sizing.height(3);
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_getTimeText(index),
                  style: TextStyle(fontSize: _size * 0.9)),
              IconButton(
                  icon:
                      Icon(Icons.remove, size: _size * 1.2, color: Colors.red),
                  onPressed: () => setState(() => _list.removeAt(index)))
            ],
          );
        });
  }
}
