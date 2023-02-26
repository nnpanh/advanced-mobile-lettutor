import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/model/lesson_model.dart';
import 'package:lettutor/model/review_model.dart';
import 'package:lettutor/model/user_model.dart';

import '../config/router.dart';
import '../model/course_model.dart';
import '../model/tutor_model.dart';

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

String getDateString(DateTime value, String getType) {
  String dayOfWeek = DateFormat('EEEE').format(value);
  String dateNo =  "$dayOfWeek, ${value.day}/${value.month}/${value.year}";
  String dateOnly =  "${value.day}/${value.month}/${value.year}";
  String time = DateFormat.Hms().format(value);
  switch(getType) {
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
  int reachedHome = 0;
  Navigator.pushNamedAndRemoveUntil(context, newRoute??MyRouter.home, (route) {
    if (reachedHome == 1) {
      return true;
    } else {
      if (route.settings.name == MyRouter.home) {
        reachedHome++;
        //If want to keep home before this newRoute screen -> newRoute not null
        if (newRoute!=null && newRoute!=MyRouter.home) return true;
      }
      return false;
    }
  });
}

void pushUntilLogin(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(context, MyRouter.login, (route) => false);
}

List<LessonModel> generateLessons() {
  List<LessonModel> lessons = [];
  var sampleLesson = LessonModel('Kimetsu no Yaiba','Shuumatsu no Valkyrie', DateTime.now(), DateTime.now().add(const Duration(hours:1)), "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand", "I will leave before the lessson ends about 5mins");
  var sampleLesson2 = LessonModel('Shuumatsu no Valkyrie: Ragnarok War of God and Humans','Kain', DateTime.now(),DateTime.now().add(const Duration(hours:1)), "https://www.linkpicture.com/q/306931717_180342937860292_6628553018679771531_n.jpg",null);
  for (var i = 5; i >= 1; i--) {
    lessons.add(sampleLesson);
    lessons.add(sampleLesson2);
  }

  return lessons;
}
List<String> generateDayList() {
  return ['21/2 (Today)', '22/2', '23/2', '24/2', '25/2', '26/2', '27/2'];
}
List<ReviewModel> generateReviewList() {
  var sampleReview = ReviewModel(
      "Kinn",
      "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand",
      "Lorem Ipsum is simply dummy text of the printing and typesett",
      3.5,
      DateTime.now());
  var sampleReview2 = ReviewModel(
      "Geto",
      "https://www.linkpicture.com/q/306931717_180342937860292_6628553018679771531_n.jpg",
      "Lorem Ipsum is simply dummy text of the printing and typesett",
      2,
      DateTime.now());

  List<ReviewModel> reviewList = [];
  for (var i = 10; i >= 1; i--) {
    reviewList.add(sampleReview);
    reviewList.add(sampleReview2);
  }
  return reviewList;
}
List<CourseModel> generateCourses() {
  List<CourseModel> courseList = [];
  var sampleCourse = CourseModel(
    'Learning about the void',
    "Lorem Ipsum is simply dummy text of the printing and",
    "Advanced",
    ["Chapter 1", "Chapter 1", "Chapter 1"],
    "https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e",
    ["Kuroko Testuya", "Aomine Daiki", "Kise Ryota"],
  );

  var sampleCourse2 = CourseModel(
    'Demon Slayer: Kimetsu no Yaiba – The Hinokami Chronicles',
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "Intermediate",
    ["Chapter 1", "Chapter 1", "Chapter 1"],
    "https://camblycurriculumicons.s3.amazonaws.com/5e2b895e541a832674533c18?h=d41d8cd98f00b204e9800998ecf8427e",
    ["Kuroko Testuya", "Aomine Daiki", "Kise Ryota"],
  );

  for (var i = 3; i >= 1; i--) {
    courseList.add(sampleCourse);
    courseList.add(sampleCourse2);
  }
  return courseList;
}
TutorModel testTutor() {
  return TutorModel(
      'Shuumatsu no Valkyrie: Ragnarok War of God and Humans',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      true,
      true,
      ['IELTS', 'TOEIC'],
      "https://www.linkpicture.com/q/306931717_180342937860292_6628553018679771531_n.jpg",
      'Vietnamese',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      generateCourses());
}

UserModel testUser() {
  return UserModel(
      'Kimetsu no Yaiba',
      'yuuhizaka194@gmail.com',
      'Vietnamese',
      '0988012170',
      Speciality.toeic.name,
      null,
      'https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand',
  'e196c821-b532-4745-93fe-e9e4cab83c46');
}

String? hiddenEmail(String? email) {
  if (email==null || email.isEmpty || email.length<7) {
    return email;
  } else {
    String first = email.substring(0, 3);
    String last = email.substring(email.length-3, email.length);
    String toHidden = first;
    for (var i = email.length-7; i >= 1; i--) {
      toHidden="$toHidden*";
    }
    return "$toHidden$last";
  }
}

List<TutorModel> generateTutorList() {
  List<TutorModel> tutorList = [];
  List<CourseModel> courseList = generateCourses();

  var sampleTutor = TutorModel(
      'Shuumatsu no Valkyrie: Ragnarok War of God and Humans',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      true,
      true,
      ['IELTS', 'TOEIC'],
      "https://www.linkpicture.com/q/306931717_180342937860292_6628553018679771531_n.jpg",
      'Vietnamese',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      courseList);
  var sampleTutor2 = TutorModel(
      'Shuumatsu no Valkyrie',
      "Very short intro",
      false,
      false,
      ['IELTS', 'TOEIC'],
      "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand",
      'Vietnamese',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      courseList);

  for (var i = 3; i >= 1; i--) {
    tutorList.add(sampleTutor);
    tutorList.add(sampleTutor2);
  }
  return tutorList;
}
