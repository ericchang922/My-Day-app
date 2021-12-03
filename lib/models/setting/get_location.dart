import 'dart:convert';

GetLocationModel getLocationModelFromJson(String str) => GetLocationModel.fromJson(json.decode(str));

String getLocationModelToJson(GetLocationModel data) => json.encode(data.toJson());

class GetLocationModel {
    GetLocationModel({
        this.location				,
    });
    
    bool location		;

    factory GetLocationModel.fromJson(Map<String, dynamic> json) => GetLocationModel(
      location	: json["location"],
    );

    Map<String, dynamic> toJson() => {
        "location	": location	,
    };
}

