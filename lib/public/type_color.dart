import 'package:flutter/material.dart';

final List<dynamic> _typeColor = [
  0xffF78787,
  0xffFFD51B,
  0xffFFA800,
  0xffB6EB3A,
  0xff53DAF0,
  0xff4968BA,
  0xffCE85E4,
  0xff8E7A42
];

Color typeColor(int typeId) => Color(_typeColor[typeId-1]);  
