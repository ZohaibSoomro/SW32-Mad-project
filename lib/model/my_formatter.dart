import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormattedDate {
//return date in format Dec 21, 2021
  String getFormattedDate({DateTime? dateTime}) {
    final date = dateTime?.toString() ?? DateTime.now().toString();
    final parsedDate = DateTime.parse(date);
    // final formattedDate =
    //     "${parsedDate.day}-${parsedDate.month}-${parsedDate.year}";
    final formattedDate = DateFormat.yMMMEd()
        .format(DateTime(parsedDate.year, parsedDate.month, parsedDate.day));
    return formattedDate;
  }

//return time in format 3:45 AM/PM
  String getFormattedTimeFromDateTime({required DateTime dateTime}) {
    final date = dateTime.toString();
    final parsedDate = DateTime.parse(date);
    final dateString =
        "${parsedDate.hour}:${parsedDate.minute}:${parsedDate.second}";

    final formattedDate =
        DateFormat.jm().format(DateFormat("hh:mm:ss").parse(dateString));
    return formattedDate;
  }

//return time in format 3:45 AM/PM
  String getFormattedTimeFromTimeOfDay({required TimeOfDay timeOfDay}) {
    String hour = timeOfDay.hourOfPeriod.toString();
    String minutes =
        timeOfDay.minute < 10 ? '0${timeOfDay.minute}' : '${timeOfDay.minute}';
    String meridiem = timeOfDay.period.toString().substring(10);
    String formattedTime = '$hour:$minutes $meridiem';

    return formattedTime;
  }

  String addTime(
      {required TimeOfDay taskStartTime, required Duration duration}) {
    int minuteSum =
        taskStartTime.hour * 60 + taskStartTime.minute + duration.inMinutes;
    int hours = 0;
    if (minuteSum >= 60) {
      hours += minuteSum ~/ 60;
      minuteSum = minuteSum % 60;
    }
    taskStartTime = TimeOfDay(hour: hours, minute: minuteSum);
    return getFormattedTimeFromTimeOfDay(timeOfDay: taskStartTime);
  }

  static TimeOfDay parseTime(String timeString) {
    //in 12 hour format not in 24 hour format
    int hours = int.parse(timeString.substring(0, timeString.indexOf(':')));
    int minutes = int.parse(timeString.substring(
        timeString.indexOf(':') + 1, timeString.indexOf(' ')));
    String meridium =
        timeString.substring(timeString.lastIndexOf(' ') + 1).toUpperCase();
    if (meridium == 'PM') hours += 12;
    return TimeOfDay(hour: hours, minute: minutes);
  }
}
