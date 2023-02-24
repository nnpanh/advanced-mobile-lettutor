import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/model/review_model.dart';

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

List<String> generateDayList() {
  return ['21/2 (Today)', '22/2', '23/2', '24/2', '25/2', '26/2', '27/2'];
}

void popUntilHomeAndRefresh(BuildContext context) {
  int reachedHome = 0;
  Navigator.pushNamedAndRemoveUntil(context, MyRouter.home, (route) {
    if (reachedHome == 1) {
      return true;
    } else {
      if (route.settings.name == MyRouter.home) {
        reachedHome++;
      }
      return false;
    }
  });
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
    "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand",
  );

  var sampleCourse2 = CourseModel(
      'Demon Slayer: Kimetsu no Yaiba – The Hinokami Chronicles',
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      "Intermediate",
      ["Chapter 1", "Chapter 1", "Chapter 1"],
      "https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand");

  for (var i = 3; i >= 1; i--) {
    courseList.add(sampleCourse);
    courseList.add(sampleCourse2);
  }
  return courseList;
}

List<TutorModel> generateDummiesList() {
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
