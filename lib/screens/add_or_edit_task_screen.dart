import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/database/tasks_database.dart';
import 'package:sw32_mad_project/components/task/model/task.dart';
import 'package:sw32_mad_project/components/widgets/custom_widgets.dart';
import 'package:sw32_mad_project/model/my_formatter.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class AddOrEditTaskScreen extends StatefulWidget {
  const AddOrEditTaskScreen(
      {Key? key,
      required this.screenMode,
      this.taskToBeUpdated,
      required this.onTaskAdded})
      : super(key: key);
  final TaskScreenMode screenMode;
  final Task? taskToBeUpdated;
  final Function() onTaskAdded;
  static Future<dynamic> showAddOrEditTaskScreen(
      BuildContext context, TaskScreenMode taskScreenMode,
      {Task? taskToBeUpdated, Function()? onTaskAddedOrUpdated}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Wrap(
        children: [
          AddOrEditTaskScreen(
            screenMode: taskScreenMode,
            taskToBeUpdated: taskToBeUpdated,
            onTaskAdded: onTaskAddedOrUpdated ?? () {},
          ),
        ],
      ),
    );
  }

  @override
  State<AddOrEditTaskScreen> createState() => _AddOrEditTaskScreenState();
}

class _AddOrEditTaskScreenState extends State<AddOrEditTaskScreen> {
  bool isFavourite = false;
  String? taskTitle = '';
  int? taskId;
  String? taskDescription = '';
  String? taskDuration = '0';
  DateTime taskDate = DateTime.now();
  TimeOfDay taskTime = TimeOfDay.now();
  bool dataInserted =
      true; //true for the first time to show screen without error message
  final FormattedDate formattedDate = FormattedDate();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  @override
  void initState() {
    widget.screenMode == TaskScreenMode.edit
        ? fillDataWithInTextFields()
        : setTaskID();
    super.initState();
  }

  void setTaskID() async {
    int idOfLastTask = await TasksDatabase.instance.getLastTaskId();
    setState(() {
      taskId = idOfLastTask + 1;
      // print('New Task Id: $taskId');
    });
  }

  void fillDataWithInTextFields() {
    setState(() {
      Task task = widget.taskToBeUpdated!;
      taskId = task.id;
      titleController.text = task.taskTitle;
      descriptionController.text =
          task.taskDescription!.toLowerCase() == 'not found!'
              ? ''
              : task.taskDescription!;
      durationController.text = task.taskDuration.inMinutes.toString();
      taskTitle = task.taskTitle;
      taskDescription = task.taskDescription;
      taskDuration = task.taskDuration.inMinutes.toString();
      isFavourite = task.isFavourite;
      taskDate = task.taskDate;
      taskTime = task.taskStartTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: RoundedContainer(
        borderRadius: 40,
        isBorderRadiusForAll: false,
        margin: 0,
        color: kLightBlue,
        //if data is not inserted and the add button is pressed
        child: !dataInserted
            ? Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 10,
                          ),
                          Icon(
                            Icons.error,
                            size: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Expanded(
                        child: Text(
                          'PLease enter all data!',
                          style: kLabelTextStyle,
                        ),
                      ),
                    ],
                  ),
                  RoundedButton(
                    buttonText: 'Try Again',
                    color: kLightPink,
                    onPressed: () => setState(() {
                      dataInserted = !dataInserted;
                    }),
                  ),
                ],
              )
            : Column(
                children: [
                  Text(
                    widget.screenMode == TaskScreenMode.add
                        ? 'Add a Task'
                        : 'Edit Task',
                    style: kLabelTextStyle,
                  ),
                  RoundedTextField(
                    textController: titleController,
                    label: 'Task Title',
                    onChanged: (newValue) {
                      setState(() {
                        taskTitle = newValue.toUpperCase();
                      });
                    },
                  ),
                  RoundedTextField(
                    textController: descriptionController,
                    label: 'Task Description',
                    onChanged: (newValue) {
                      setState(() {
                        taskDescription = newValue.toUpperCase();
                      });
                    },
                  ),
                  RoundedTextField(
                    textController: durationController,
                    label: 'Task Duration in minutes',
                    suffixText: 'minutes',
                    keyboardType: TextInputType.number,
                    onChanged: (newValue) {
                      setState(() {
                        taskDuration = newValue;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: const [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Favourite ',
                            style: kDpInfoTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isFavourite ? 'Yes' : 'No',
                            style: kNormalTextStyle,
                          ),
                          Switch(
                            activeColor: kLightPink,
                            inactiveThumbColor: Colors.white,
                            value: isFavourite,
                            onChanged: (val) {
                              setState(() {
                                isFavourite = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Date ',
                            style: kNormalTextStyle,
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          Text(
                            formattedDate.getFormattedDate(dateTime: taskDate),
                            style: kNormalTextStyle,
                          ),
                        ],
                      ),
                      RoundedButton(
                        buttonText: 'Select Date',
                        color: kLightPink,
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Time ',
                            style: kNormalTextStyle,
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                          Text(
                            formattedDate.getFormattedTimeFromTimeOfDay(
                                timeOfDay:
                                    taskTime), //DayPeriod.Am or DayPeriod.Pm
                            style: kNormalTextStyle,
                          ),
                        ],
                      ),
                      RoundedButton(
                        buttonText: 'Set Time',
                        color: kLightPink,
                        onPressed: () => _selectTime(context),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RoundedButton(
                        buttonText: widget.screenMode == TaskScreenMode.add
                            ? 'Add Task'
                            : 'Update task',
                        color: kLightPink,
                        onPressed: () async {
                          Task task = Task(
                            id: taskId!,
                            taskTitle: taskTitle!,
                            taskDate: taskDate,
                            isFavourite: isFavourite,
                            taskStartTime: taskTime,
                            taskDuration: taskDuration != ''
                                ? Duration(
                                    minutes: int.parse(taskDuration!),
                                  ) //if nothing has been entered in task duration field (in update mode)
                                : const Duration(minutes: 0),
                            taskDescription:
                                taskDescription == '' ? null : taskDescription,
                          );
                          // print('$task added');
                          if (taskTitle == '' ||
                              taskDuration == '0' ||
                              taskDuration == '') {
                            setState(() {
                              dataInserted = !dataInserted;
                            });
                          } else {
                            widget.screenMode == TaskScreenMode.add
                                ? addTask(task)
                                : updateTask(task);
                            await widget.onTaskAdded.call();
                            Navigator.pop(context, task);
                          }
                        },
                      ),
                      RoundedButton(
                        buttonText: 'Dismiss',
                        color: kLightPink,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> addTask(Task task) async {
    await TasksDatabase.instance.insertTask(task);
  }

  Future<int> updateTask(Task? task) async {
    int updatedRows = await TasksDatabase.instance.updateTask(task!);
    return updatedRows;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: taskDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),
    );
    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        taskDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? response = await showTimePicker(
      context: context,
      initialTime: taskTime,
      confirmText: 'SET',
    );
    if (response != null && response != taskTime) {
      setState(() {
        taskTime = response;
      });
    }
  }
}

enum TaskScreenMode {
  add,
  edit,
}
