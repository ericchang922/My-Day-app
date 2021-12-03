import 'dart:convert';

import 'package:My_Day_app/public/convert.dart';

GetNoticeModel getNoticeModelFromJson(String str) =>
    GetNoticeModel.fromJson(json.decode(str));

String getNoticeModelToJson(GetNoticeModel data) => json.encode(data.toJson());

class GetNoticeModel {
  GetNoticeModel({
    this.scheduleNotice,
    this.temporaryNotice,
    this.countdownNotice,
    this.groupNotice,
  });

  bool scheduleNotice;
  bool temporaryNotice;
  bool countdownNotice;
  bool groupNotice;

  factory GetNoticeModel.fromJson(Map<String, dynamic> json) => GetNoticeModel(
        scheduleNotice: json["scheduleNotice"],
        temporaryNotice: json["temporaryNotice"],
        countdownNotice: json["countdownNotice"],
        groupNotice: json["groupNotice"],
      );

  Map<String, dynamic> toJson() => {
        "scheduleNotice": scheduleNotice,
        "temporaryNotice": temporaryNotice,
        "countdownNotice": countdownNotice,
        "groupNotice": groupNotice,
      };
}
