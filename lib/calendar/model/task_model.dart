import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    required this.active,
    required this.date,
    required this.dateCreated,
    required this.dateUpdate,
    required this.description,
    required this.taskId,
    required this.userId,
  });

  bool active;
  String date;
  String dateCreated;
  String dateUpdate;
  String description;
  String taskId;
  String userId;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        active: json["active"],
        date: json["date"],
        dateCreated: json["date_created"],
        dateUpdate: json["date_update"],
        description: json["description"],
        taskId: json["task_id"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "date": date,
        "date_created": dateCreated,
        "date_update": dateUpdate,
        "description": description,
        "task_id": taskId,
        "user_id": userId,
      };
}
