import 'dart:convert';

GetNoticeModel getNoticeModelFromJson(String str) => GetNoticeModel.fromJson(json.decode(str));

String getNoticeModelToJson(GetNoticeModel data) => json.encode(data.toJson());

class GetNoticeModel {
    GetNoticeModel({
        this.schedulenotice,
        this.temporaryNotice,
        this.countdownNotice,
        this.groupNotice	,
    });
    
    bool schedulenotice		;
    bool temporaryNotice		;
    bool countdownNotice		;
    bool groupNotice			;

    factory GetNoticeModel.fromJson(Map<String, dynamic> json) => GetNoticeModel(
      schedulenotice	: json["schedulenotice"],
      temporaryNotice	: json["temporaryNotice"],
      countdownNotice	: json["countdownNotice"],
      groupNotice		: json["groupNotice	"],
    );

    Map<String, dynamic> toJson() => {
        "schedulenotice	": schedulenotice	,
        "temporaryNotice	": temporaryNotice	,
        "countdownNotice	": countdownNotice	,
        "groupNotice		": groupNotice		,
    };
}

