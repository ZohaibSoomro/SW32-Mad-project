import 'package:flutter/material.dart';
import 'package:sw32_mad_project/database/database_helper.dart';

import 'model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];
  bool tasksLoading = false;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() {
      tasksLoading = true;
    });
    final tasks = await TasksDatabase.instance.getTasks();
    setState(() {
      _tasks = tasks;
      tasksLoading = false;
    });
    print('Tasks: $tasks');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: tasksLoading
            ? const Center(child: Text('no'))
            : _tasks.isEmpty
                ? const Center(
                    child: Text('No Tasks Added!'),
                  )
                : SingleChildScrollView(
                    child: ListView.builder(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) =>
                          Text(_tasks[index].title),
                    ),
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? taskTitle;
          const textStyle = TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          );
          SnackBar getSnackBar(
              {String text = 'Please enter a title!', TextStyle? textStyle2}) {
            return SnackBar(
              content: Text(
                text,
                style: textStyle2 ?? textStyle,
              ),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              duration: const Duration(seconds: 1),
            );
          }

          showModalBottomSheet(
            elevation: 1,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add a Task',
                      style: textStyle,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: textStyle.copyWith(fontSize: 20),
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) => setState(() {
                        taskTitle = value;
                      }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (taskTitle != null && taskTitle != '') {
                            Task task = Task(title: taskTitle!);
                            int idOfAddedTask =
                                await TasksDatabase.instance.addTask(task);
                            if (idOfAddedTask != 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  getSnackBar(
                                      text:
                                          '${task.title} added successfully.'));
                              Navigator.pop(context);
                            }
                          }
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar());
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            'Add Task',
                            style: textStyle.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
        tooltip: 'Add Text',
        child: const Icon(Icons.add),
      ),
    );
  }
}
