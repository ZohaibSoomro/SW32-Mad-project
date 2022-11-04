import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/task/model/task.dart';
import 'package:sw32_mad_project/components/widgets/custom_widgets.dart';
import 'package:sw32_mad_project/model/custom_padding.dart';
import 'package:sw32_mad_project/screens/add_or_edit_task_screen.dart';
import 'package:sw32_mad_project/styles/colors.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

import '../task/widgets/task_tile.dart';

class HomePageContent extends StatelessWidget {
  final List<Task> tasks;
  final bool areFavourites;
  final Function() onLoadingCompleted;
  const HomePageContent({
    Key? key,
    required this.tasks,
    required this.areFavourites,
    required this.onLoadingCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: tasks.isEmpty
              ? Center(
                  child: Text(
                  areFavourites ? 'No Favourite Tasks! ' : 'No Tasks!',
                  textAlign: TextAlign.center,
                  style: kTitleTextStyle,
                ))
              : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => TaskTile(
                      task: tasks[index],
                      isFirstTaskTile: index == 0 ? true : false,
                      onTileTapped: onLoadingCompleted),
                ),
        ),
        RoundedButton(
          buttonText: 'Add New Task',
          color: kLightPurple,
          padding: CustomPadding().symmetricPadding(0, 10),
          onPressed: () {
            AddOrEditTaskScreen.showAddOrEditTaskScreen(
              context,
              TaskScreenMode.add,
              onTaskAddedOrUpdated: onLoadingCompleted,
            ).toString();
            onLoadingCompleted.call();
          },
        ),
      ],
    );
  }
}
