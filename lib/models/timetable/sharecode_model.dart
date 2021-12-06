import 'dart:convert';

SharecodeModel sharecodeModelFromJson(String str) => SharecodeModel.fromJson(json.decode(str));

String sharecodeModelToJson(SharecodeModel data) => json.encode(data.toJson());

class SharecodeModel {
    SharecodeModel({
        this.sharecode,
        this.response,
    });

    String sharecode;
    bool response;

    factory SharecodeModel.fromJson(Map<String, dynamic> json) => SharecodeModel(
        sharecode: json["sharecode"],
        response: json["response"],
    );

    Map<String, dynamic> toJson() => {
        "sharecode": sharecode,
        "response": response,
    };
}
