import 'package:flutter/material.dart';
import 'package:sw32_mad_project/components/task/model/task.dart';
import 'package:sw32_mad_project/components/widgets/custom_widgets.dart';
import 'package:sw32_mad_project/model/my_formatter.dart';
import 'package:sw32_mad_project/styles/custom_styles.dart';

import '../../widgets/custom_divider.dart';
import 'task_tile_info_dialog.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(
      {Key? key,
      required this.task,
      required this.isFirstTaskTile,
      required this.onTileTapped})
      : super(key: key);

  final Task task;
  final bool isFirstTaskTile;
  final Function() onTileTapped;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomDivider(
          visibleCircle: isFirstTaskTile,
          color: isFirstTaskTile ? kLightBlue : Colors.grey,
        ),
        Row(
          children: [
            Text(
              FormattedDate().getFormattedTimeFromTimeOfDay(
                timeOfDay: task.taskStartTime,
              ),
              style: kNormalTextStyle,
            ),
            Expanded(
              child: TaskTileInfoDialog(
                task: task,
                onTaskUpdated: onTileTapped,
                onTaskDeleted: onTileTapped,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
