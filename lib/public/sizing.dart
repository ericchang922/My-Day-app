import 'package:flutter/material.dart';

class Sizing{
  BuildContext context;
  Size _size;
  double _height = 0;
  double _width = 0;

  Sizing(this.context){
    _size = MediaQuery.of(context).size;
    _height = _size.height;
    _width = _size.width;
  }
  double height(double percent){
    return _height*(percent/100);
  }
  double width(double percent){
    return _width*(percent/100);
  }
}