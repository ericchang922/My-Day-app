import 'dart:convert';

GetThemesModel getThemesModelFromJson(String str) => GetThemesModel.fromJson(json.decode(str));

String getThemesModelToJson(GetThemesModel data) => json.encode(data.toJson());

class GetThemesModel {
    GetThemesModel({
        this.themeId			,
    });
    
    int themeId	;

    factory GetThemesModel.fromJson(Map<String, dynamic> json) => GetThemesModel(
      themeId	: json["themeId	"],
    );

    Map<String, dynamic> toJson() => {
        "themeId	": themeId	,
    };
}

