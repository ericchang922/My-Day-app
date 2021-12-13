import 'dart:convert';

import 'package:My_Day_app/public/sizing.dart';
import 'package:flutter/material.dart';

class GetImage {
  BuildContext context;
  Sizing _sizing;
  String imageString;

  GetImage(this.context) {
    _sizing = Sizing(context);
  }

  personal(String imageString) {
    return getImage(
        imageString, _sizing.height(80), _sizing.height(80), 'personal');
  }

  friend(String imageString) {
    return getImage(
        imageString, _sizing.height(4.5), _sizing.height(4.5), 'friend');
  }

  note(String imageString) {
    return getImage(imageString, null, null, 'note');
  }

  getImage(String imageString, double _weigth, double _height, String type) {
    bool isGetImage;
    Image image;

    Image friendImage = Image.asset(
      'assets/images/friend_choose.png',
      width: _height,
    );

    try {
      const Base64Codec base64 = Base64Codec();
      if (_weigth == null) {
        image = Image.memory(
          base64.decode(imageString),
        );
      } else {
        image = Image.memory(base64.decode(imageString),
            width: _weigth, height: _height, fit: BoxFit.cover);
      }
      var resolve = image.image.resolve(ImageConfiguration.empty);
      resolve.addListener(ImageStreamListener((_, __) {
        isGetImage = true;
      }, onError: (Object exception, StackTrace stackTrace) {
        isGetImage = false;
        print('error');
      }));
    } catch (error) {
      print('圖片讀取錯誤：${error}');
      isGetImage = false;
    }

    if (isGetImage == null) {
      return image;
    } else {
      if (type == 'friend' || type == 'personal')
        return friendImage;
      else
        return Center(
          child: Text('無法讀取'),
        );
    }
  }
}
