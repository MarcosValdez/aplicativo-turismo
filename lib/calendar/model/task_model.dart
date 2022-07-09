import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    required this.date,
     required this.dateCreated,
    required this.description,
    required this.user,
  });

  String date;
  String dateCreated;
  String description;
  int user;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        date: json["date"],
        dateCreated: json["date_created"],
        description: json["description"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "date_created": dateCreated,
        "description": description,
        "user": user,
      };
}
