import 'dart:convert';

ThemeModel themeModelFromJson(String str) => ThemeModel.fromJson(json.decode(str));

String themeModelToJson(ThemeModel data) => json.encode(data.toJson());

class ThemeModel {
    ThemeModel({
        this.colorCode		,
    });
    
    String colorCode;

    factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
      colorCode: json["colorCode"],
    );

    Map<String, dynamic> toJson() => {
        "colorCode": colorCode,
    };
}

