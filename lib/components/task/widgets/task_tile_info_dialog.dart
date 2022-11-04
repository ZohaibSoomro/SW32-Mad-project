import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/database/tasks_database.dart';
import 'package:sw32_mad_project/components/task/model/task.dart';
import 'package:sw32_mad_project/components/widgets/custom_widgets.dart';
import 'package:sw32_mad_project/model/custom_padding.dart';
import 'package:sw32_mad_project/model/my_formatter.dart';
import 'package:sw32_mad_project/model/my_snack_bar.dart';
import 'package:sw32_mad_project/screens/add_or_edit_task_screen.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class TaskTileInfoDialog extends StatelessWidget {
  TaskTileInfoDialog({
    Key? key,
    required this.task,
    required this.onTaskUpdated,
    required this.onTaskDeleted,
  }) : super(key: key);

  final Task task;
  final Function() onTaskUpdated;
  final Function() onTaskDeleted;
  final FormattedDate formattedDate = FormattedDate();

  Future<int> _deleteTask(BuildContext context) async {
    int deletedRows = await TasksDatabase.instance.deleteTask(task.id);
    await onTaskDeleted.call();
    //show a message that this task has been removed from the task list successfully
    if (deletedRows > 0) {
      MySnackBar.show(
          context: context,
          text:
              'Task "${task.taskTitle}" was removed successfully from task list.');
    }
    return deletedRows;
  }

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      onLongPress: () {
        _deleteTask(context);
      },
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => RoundedDialogContainer(
            color: kLightPurple,
            context: context,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: buildTaskInfoColumn(context),
            ),
          ),
        );
      },
      borderRadius: 15.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.taskTitle,
                  style: kTileTextStyle,
                ),
                Text(
                  calculateTaskDateLabel()
                      .substring(calculateTaskDateLabel().indexOf(',') + 1),
                  style: kNormalTextStyle,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      formattedDate.getFormattedTimeFromTimeOfDay(
                        timeOfDay: task.taskStartTime,
                      ),
                    ),
                    Container(
                      margin: CustomPadding().symmetricPadding(5, 0),
                      height: 1,
                      width: 20,
                      color: Colors.white,
                    ),
                    Text(
                      formattedDate.addTime(
                        taskStartTime: task.taskStartTime,
                        duration: task.taskDuration,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    task.isFavourite = !task.isFavourite;
                    await TasksDatabase.instance.updateTask(task);
                    await onTaskUpdated.call();
                  },
                  child: Icon(
                    task.isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red[400],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      color: kLightBlue,
    );
  }

  //   IconButton(
  //   icon: Icon(task.isFavourite
  //       ? Icons.favorite
  //       : Icons.favorite_border),
  //   color: Colors.amberAccent,
  //   onPressed: () {
  //     Provider.of<TaskList>(context, listen: false)
  //         .toggleTaskIsFavourite(task);
  //   },
  // ),
  Column buildTaskInfoColumn(BuildContext context) {
    //computation for outputting time in hours and minutes
    int minutes = task.taskDuration.inMinutes;
    int hours = 0;
    if (minutes >= 60) {
      hours += minutes ~/ 60;
      minutes = minutes % 60;
    }
    String dateText = calculateTaskDateLabel();
    //checking if date is today

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Center(
          child: Text(
            task.taskTitle,
            style: kTitleTextStyle,
          ),
        ),
        buildTaskInfoItem(
            'Description: ${task.taskDescription ?? ' Not found!'}'),
        buildTaskInfoItem('Is Favourite: ${task.isFavourite ? 'Yes' : 'No'}'),
        buildTaskInfoItem(
            'Starts at: ${formattedDate.getFormattedTimeFromTimeOfDay(timeOfDay: task.taskStartTime)}'),
        buildTaskInfoItem(
            'Duration: ${hours != 0 ? '$hours hours ${minutes != 0 ? '$minutes minutes ' : ''}' : '$minutes minutes'}'),
        buildTaskInfoItem(
          'Date: $dateText',
        ),
        Wrap(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RoundedButton(
                  onPressed: () => Navigator.pop(context),
                  buttonText: 'Ok',
                  color: kLightPink,
                  marginValue: 2,
                  paddingValue: 10,
                ),
                RoundedButton(
                  marginValue: 2,
                  paddingValue: 8,
                  onPressed: () async {
                    var response =
                        await AddOrEditTaskScreen.showAddOrEditTaskScreen(
                      context,
                      TaskScreenMode.edit,
                      taskToBeUpdated: task,
                      onTaskAddedOrUpdated: onTaskUpdated,
                    );
                    if (response == null) {
                      Navigator.pop(context);
                    }
                  },
                  buttonText: 'Edit',
                  color: kLightPink,
                ),
                RoundedButton(
                  onPressed: () async {
                    int deletedRows = await _deleteTask(context);
                    if (deletedRows > 0) {
                      final tasks = await onTaskDeleted.call();
                      if (tasks != null) {
                        Navigator.pop(context);
                      }
                    }
                  },
                  buttonText: 'Delete',
                  color: kLightPink,
                  marginValue: 2,
                  paddingValue: 8,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

  Text buildTaskInfoItem(String text) {
    return Text(
      text,
      style: kNormalTextStyle,
    );
  }

  String calculateTaskDateLabel() {
    DateTime dateTime = DateTime.now();
    String dateText = (dateTime.day == task.taskDate.day &&
            dateTime.year == task.taskDate.year)
        ? 'Today'
        : (dateTime.day + 1 == task.taskDate.day &&
                dateTime.year == task.taskDate.year)
            ? 'Tomorrow'
            : formattedDate.getFormattedDate(dateTime: task.taskDate);
    return dateText;
  }
}
