import 'dart:convert';

class GroupModel {
    GroupModel({
        this.groupId,
        this.title,
        this.typeId,
        this.peopleCount,
    });

    int groupId;
    String title;
    int typeId;
    int peopleCount;
}
