import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const/const_value.dart';

import '../config/router.dart';

ThemeMode getDeviceThemeMode() {
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;
  if (brightness == Brightness.light) {
    return ThemeMode.light;
  } else {
    return ThemeMode.dark;
  }
}

//Heigh x 5 lines + padding = 16x2
double getDescriptionHeight(BuildContext context) {
  double textHeight =
      Theme.of(context).textTheme.bodyLarge?.fontSize?.toDouble() ?? 14;
  return textHeight * ConstValue.descriptionTextScale * 5 + 16 * 2;
}

double getMaxLineHeightByLines(BuildContext context, int lines) {
  double textHeight =
      Theme.of(context).textTheme.bodyLarge?.fontSize?.toDouble() ?? 14;
  return textHeight * ConstValue.descriptionTextScale * lines + 16 * 2;
}

DateTime getDateTimeFromInt(int value) {
  return DateTime.fromMicrosecondsSinceEpoch(value);
}

String getDateString(DateTime value, String getType) {
  String dayOfWeek = DateFormat('EEEE').format(value);
  String dateNo = "$dayOfWeek, ${value.day}/${value.month}/${value.year}";
  String dateOnly = "${value.day}/${value.month}/${value.year}";
  String time = DateFormat.Hms().format(value);
  switch (getType) {
    case TimeFormat.getDateNo:
      return dateNo;
    case TimeFormat.getTime:
      return time;
    case TimeFormat.getDateAndTime:
      return "$dateNo - $time";
    case TimeFormat.getDateOnly:
      return dateOnly;
    default:
      return "$dateNo - $time";
  }
}

String formatDateStringFromApi(String? value) {
  if (value == null) return "";
  var values = value.split("-");
  return "${values[2]}/${values[1]}/${values[0]}";
}

String formatDateStringToApi(String? value) {
  if (value == null) return "";
  var values = value.split("/");
  return "${values[2]}-${values[1]}-${values[0]}";
}

String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  if (diff.inDays > 365) {
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (diff.inDays > 30) {
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (diff.inDays > 7) {
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (diff.inDays > 0) {
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  }
  if (diff.inHours > 0) {
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (diff.inMinutes > 0) {
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
  }
  return "Just now";
}

void pushNamedAndRemoveUntilHome(BuildContext context, {String? newRoute}) {
  if (newRoute == MyRouter.home) {
    popUntilHome(context);
  } else {
    int reachedHome = 0;
    Navigator.pushNamedAndRemoveUntil(context, newRoute ?? MyRouter.home,
        (route) {
      if (reachedHome == 1) {
        return true;
      } else {
        if (route.settings.name == MyRouter.home) {
          reachedHome++;
          //If want to keep home before this newRoute screen -> newRoute not null
          if (newRoute != null && newRoute != MyRouter.home) return true;
        }
        return false;
      }
    });
  }
}

void popUntilHome(BuildContext context) {
  Navigator.popUntil(context, (route) {
    if (route.settings.name == MyRouter.home) {
      return true;
    }
    return false;
  });
}

void pushUntilLogin(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, MyRouter.login, (route) => false);
  Navigator.pushNamed(context, MyRouter.login);
}

String? hiddenEmail(String? email) {
  if (email == null || email.isEmpty || email.length < 7) {
    return email;
  } else {
    String first = email.substring(0, 3);
    String last = email.substring(email.length - 3, email.length);
    String toHidden = first;
    for (var i = email.length - 7; i >= 1; i--) {
      toHidden = "$toHidden*";
    }
    return "$toHidden$last";
  }
}

extension DateTimeFromTimeOfDay on DateTime {
  DateTime appliedFromTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime.utc(year, month, day, timeOfDay.hour, timeOfDay.minute);
  }
}

int getShowPagesBasedOnPages(int pages) {
  if (pages > 2) {
    return 2;
  } else if (pages == 2) {
    return 1;
  } else if (pages <= 1) {
    return 0;
  } else {
    return 0;
  }
}
