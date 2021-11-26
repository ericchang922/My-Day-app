import 'dart:convert';

GetProfileListModel getProfileListModelFromJson(String str) => GetProfileListModel.fromJson(json.decode(str));

String getProfileListModelToJson(GetProfileListModel data) => json.encode(data.toJson());

class GetProfileListModel {
    GetProfileListModel({
       this.photo,
       this.userName,
       
    });
    
    String photo;
    String userName;

    factory GetProfileListModel.fromJson(Map<String, dynamic> json) => GetProfileListModel(
      photo	: json["photo"],
      userName	: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "photo	": photo	,
        "userName	": userName	,
    };
}

