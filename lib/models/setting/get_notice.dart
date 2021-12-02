import 'dart:convert';

import 'package:My_Day_app/public/convert.dart';

GetNoticeModel getNoticeModelFromJson(String str) =>
    GetNoticeModel.fromJson(json.decode(str));

String getNoticeModelToJson(GetNoticeModel data) => json.encode(data.toJson());

class GetNoticeModel {
  GetNoticeModel({
    this.schedulenotice,
    this.temporaryNotice,
    this.countdownNotice,
    this.groupNotice,
  });

  bool schedulenotice;
  bool temporaryNotice;
  bool countdownNotice;
  bool groupNotice;

  factory GetNoticeModel.fromJson(Map<String, dynamic> json) => GetNoticeModel(
        schedulenotice: ConvertInt.toBool(json["schedulenotice"]),
        temporaryNotice: ConvertInt.toBool(json["temporaryNotice"]),
        countdownNotice: ConvertInt.toBool(json["countdownNotice"]),
        groupNotice: ConvertInt.toBool(json["groupNotice	"]),
      );

  Map<String, dynamic> toJson() => {
        "schedulenotice	": schedulenotice,
        "temporaryNotice	": temporaryNotice,
        "countdownNotice	": countdownNotice,
        "groupNotice		": groupNotice,
      };
}
