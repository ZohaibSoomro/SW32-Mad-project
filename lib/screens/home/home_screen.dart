import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/database/tasks_database.dart';
import 'package:sw32_mad_project/components/task/model/task.dart';
import 'package:sw32_mad_project/components/task/model/task_list.dart';
import 'package:sw32_mad_project/components/widgets/custom_widgets.dart';
import 'package:sw32_mad_project/model/custom_padding.dart';
import 'package:sw32_mad_project/model/my_formatter.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

class HomePage extends StatefulWidget {
  static const String routeID = 'home';

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CustomPadding customPadding = CustomPadding();
  bool showFavourites = false;
  List<Task> tasks = [];
  bool tasksLoading = false;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  ///loads tasks
  Future<List<Task>> loadTasks() async {
    setState(() => tasksLoading = true);
    if (showFavourites) {
      tasks = await TasksDatabase.instance.readOnlyFvr8Tasks();
    } else {
      tasks = await TasksDatabase.instance.readAllTasks();
    }
    setState(() {
      if (tasks.isNotEmpty) tasks = sortTaskList(tasks);
      // print(tasks);
      tasksLoading = false;
    });
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          FormattedDate().getFormattedDate(dateTime: DateTime.now()),
          style: kNormalTextStyle,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: customPadding.symmetricPadding(8, 0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Expanded(
                                child: Text(
                                  showFavourites
                                      ? 'Favourite Tasks'
                                      : 'All Tasks',
                                  style: showFavourites
                                      ? kTitleTextStyle.copyWith(
                                          fontSize: 25,
                                          letterSpacing: 0.75,
                                        )
                                      : kTitleTextStyle,
                                ),
                              ),
                              Text(
                                '(${tasks.length})',
                                style: kNormalTextStyle,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            toggleShowFvr8s();
                            await loadTasks();
                          },
                          icon: showFavourites
                              ? const Icon(Icons.favorite, color: Colors.red)
                              : const Icon(Icons.favorite_border,
                                  color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              tasksLoading
                  ? const CircularProgressIndicator(
                      color: kLightBlue,
                    )
                  : Expanded(
                      child: HomePageContent(
                        areFavourites: showFavourites,
                        onLoadingCompleted: loadTasks,
                        tasks: tasks,
                      ),
                    )
            ],
          ),
        ),
      ),
      drawer: NavigationDrawer(
        isFvvr8Selected: showFavourites,
        onFvr8Selected: () async {
          toggleShowFvr8s.call();
          await loadTasks();
        },
      ),
    );
  }

  void toggleShowFvr8s() {
    setState(() {
      showFavourites = !showFavourites;
    });
  }
}
