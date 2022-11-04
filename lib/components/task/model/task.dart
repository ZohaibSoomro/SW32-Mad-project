import 'package:flutter/material.dart';
import 'package:sw32_mad_project/model/my_formatter.dart';

const String tableTasks = 'tasks';

class TaskFields {
  static const String id = 'id';
  static const String taskTitle = 'taskTitle';
  static const String taskDescription = 'taskDescription';
  static const String isFavourite = 'isFavourite';
  static const String taskDate = 'taskDate';
  static const String taskStartTime = 'taskStartTime';
  static const String taskDuration = 'taskDuration';

  static const List<String> values = [
    id,
    taskTitle,
    taskDescription,
    isFavourite,
    taskDate,
    taskStartTime,
    taskDuration
  ];
}

class Task {
  final int id;
  String taskTitle;
  String? taskDescription;
  bool isFavourite;
  DateTime taskDate;
  TimeOfDay taskStartTime;
  Duration taskDuration;

  Task({
    required this.id,
    required this.taskTitle,
    this.taskDescription,
    required this.taskDate,
    required this.taskStartTime,
    required this.taskDuration,
    this.isFavourite = false,
  });

  Task updateTo(Task task) {
    taskTitle = task.taskTitle;
    taskDescription = task.taskDescription;
    taskDate = task.taskDate;
    taskStartTime = task.taskStartTime;
    taskDuration = task.taskDuration;
    isFavourite = task.isFavourite;
    return this;
  }

  @override
  String toString() {
    FormattedDate fdate = FormattedDate();
    String taskString =
        '{id: $id \nTitle: $taskTitle,\nDescription: $taskDescription,\nDuration: ${taskDuration.inMinutes} mins,\nFavourite: $isFavourite,\nStarts at: ${fdate.getFormattedTimeFromTimeOfDay(timeOfDay: taskStartTime)},\nDate: ${fdate.getFormattedDate(dateTime: taskDate)}}';
    return taskString;
  }

  Map<String, Object?> toJSON() => {
        TaskFields.id: id,
        TaskFields.taskTitle: taskTitle,
        TaskFields.taskDescription: taskDescription,
        TaskFields.isFavourite: isFavourite ? 1 : 0,
        //this format can be parsed back to original date using DateTime.parse(stringHere) method
        TaskFields.taskDate: taskDate.toIso8601String(),
        TaskFields.taskStartTime: FormattedDate()
            .getFormattedTimeFromTimeOfDay(timeOfDay: taskStartTime),
        TaskFields.taskDuration: taskDuration.inMinutes,
      };

  static Task fromJSON(Map<String, Object?> json) => Task(
        id: json[TaskFields.id] as int,
        taskTitle: json[TaskFields.taskTitle] as String,
        taskDescription:
            (json[TaskFields.taskDescription] ?? 'Not Found!') as String,
        taskDuration: Duration(minutes: json[TaskFields.taskDuration] as int),
        taskDate: DateTime.parse(json[TaskFields.taskDate] as String),
        taskStartTime:
            FormattedDate.parseTime(json[TaskFields.taskStartTime] as String),
        isFavourite: json[TaskFields.isFavourite] == 1,
      );
}
