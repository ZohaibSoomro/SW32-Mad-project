// import 'dart:collection';

// import 'package:flutter/material.dart';
// import 'package:sw32_mad_project/components/task/model/task.dart';

// class TaskList {
//   static const id = 'Tasks';

//   final List<Task> _taskList = [];

//   void addTask(Task task) {
//     _taskList.add(task);
//     sortTaskList();
//   }

//   List<Task> get taskList {
//     return UnmodifiableListView(_taskList);
//   }

//   void removeTask(Task task) {
//     _taskList.remove(task);
//   }

//   Task at(int index) {
//     return _taskList[index];
//   }

//   int indexOf(Task task) {
//     for (int i = 0; i < taskListSize; i++) {
//       if (at(i).taskDate == task.taskDate &&
//           at(i).taskTitle == task.taskTitle &&
//           at(i).taskDescription == task.taskDescription &&
//           at(i).taskStartTime == at(i).taskStartTime &&
//           at(i).taskDuration == at(i).taskDuration) {
//         return i;
//       }
//     }
//     return -1;
//   }

//   void updateTask(int taskIndex, Task task) {
//     _taskList[taskIndex] = task;
//     sortTaskList();
//   }

//   void toggleTaskIsFavourite(Task task) {
//     int index = indexOf(task);
//     _taskList[index].isFavourite = !_taskList[index].isFavourite;
//   }

//   void removeTaskAtIndex(int index) {
//     _taskList.removeAt(index);
//     sortTaskList();
//   }

//   int get taskListSize {
//     return _taskList.length;
//   }

import 'package:flutter/material.dart';

import 'task.dart';

List<Task> sortByStartTime(List<Task> taskList) {
  taskList.sort((task1, task2) {
    TimeOfDay t1 = task1.taskStartTime;
    TimeOfDay t2 = task2.taskStartTime;

    if (t1.hour < t2.hour) {
      return -1;
    } else if (t1.hour > t2.hour) {
      return 1;
    } else {
      if (t1.minute < t2.minute) {
        return -1;
      } else if (t1.minute > t2.minute) {
        return 1;
      } else {
        return 0;
      }
    }
  });
  return taskList;
}

List<Task> sortByStartDate(List<Task> taskList) {
  taskList.sort((task1, task2) {
    return (task1.taskDate.compareTo(task2.taskDate));
  });
  return taskList;
}

List<Task> sortByTitle(List<Task> taskList) {
  taskList.sort((task1, task2) {
    return (task1.taskTitle.compareTo(task2.taskTitle));
  });
  return taskList;
}

List<Task> sortTaskList(List<Task> taskList) {
  //sortByTitle();
  sortByStartTime(taskList);
  sortByStartDate(taskList);
  return taskList;
}

// }
