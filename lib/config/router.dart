import 'package:flutter/material.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/view/authentication/forgot_pass_page.dart';
import 'package:lettutor/view/authentication/login_page.dart';
import 'package:lettutor/view/authentication/sign_up_page.dart';
import 'package:lettutor/view/courses/lesson_detail_page.dart';
import 'package:lettutor/view/schedule/join_meeting_page.dart';
import 'package:lettutor/view/schedule/learning_history_page.dart';
import 'package:lettutor/view/settings/account_page.dart';
import 'package:lettutor/view/settings/become_tutor_page.dart';
import 'package:lettutor/view/settings/settings_page.dart';

import '../view/common_widgets/loading_overlay.dart';
import '../view/courses/course_detail_page.dart';
import '../view/courses/courses_page.dart';
import '../view/courses/select_page.dart';
import '../view/home_page.dart';
import '../view/schedule/schedule_page.dart';
import '../view/tutors/booking_detail_page.dart';
import '../view/tutors/search_result.dart';
import '../view/tutors/tutor_detail_page.dart';
import '../view/tutors/tutors_page.dart';
import 'error_page.dart';

class MyRouter {
  static const String home = 'Homepage';

  //Courses
  static const String courses = 'Online Courses';
  static const String courseDetail = 'Course Details';
  static const String lessonDetail = 'Lesson Details';

  //Authentication
  static const String forgotPassword = 'Forgot Password';
  static const String login = 'Login';
  static const String signUp = 'Sign up';

  //Selector
  static const String selectTutorOrCourse = 'Study';

  //Tutors
  static const String tutors = 'Online Tutors';
  static const String tutorDetail = 'Tutor Details';
  static const String bookingDetail = 'Booking Details';
  static const String searchResults = 'Search Results';

  //Schedule
  static const String schedule = 'Schedule';
  static const String learningHistory = 'Learning History';
  static const String analysis = 'Analysis';

  //Meeting
  static const String joinMeeting = 'Join Meeting';
  static const String chatGpt = 'Chat GPT';

  //Settings
  static const String setting = 'Settings';
  static const String becomeTutor = 'Become A Tutor';
  static const String account = 'Edit Account';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case home:
        return successRoute(LoadingOverlay(child: const HomePage()), settings);
      //Courses
      case courses:
        return successRoute(
            LoadingOverlay(child: const CoursesPage()), settings);
      case courseDetail:
        if (args is CourseDetailArguments) {
          return successRoute(
              LoadingOverlay(
                  child: CourseDetailPage(courseModel: args.courseModel)),
              settings);
        } else {
          return errorRoute(
              'Input for Tutor detail page is not TutorDetailArguments',
              settings);
        }
      case lessonDetail:
        if (args is LessonDetailArguments) {
          return successRoute(
              LoadingOverlay(
                  child: LessonDetailPage(title: args.title, url: args.pdfUrl)),
              settings);
        } else {
          return errorRoute(
              'Input for Tutor detail page is not TutorDetailArguments',
              settings);
        }
      //Authentication
      case forgotPassword:
        return successRoute(
            LoadingOverlay(child: const ForgotPasswordPage()), settings);
      case login:
        return successRoute(LoadingOverlay(child: const LoginPage()), settings);
      case signUp:
        return successRoute(
            LoadingOverlay(child: const SignUpPage()), settings);
      //Selector
      case selectTutorOrCourse:
        return successRoute(
            LoadingOverlay(child: const SelectPage()), settings);
      //Tutors
      case tutors:
        return successRoute(
            LoadingOverlay(child: const TutorsPage()), settings);
      case tutorDetail:
        if (args is TutorDetailArguments) {
          return successRoute(
              LoadingOverlay(
                  child: TutorDetailPage(tutorModel: args.tutorModel)),
              settings);
        } else {
          return errorRoute(
              'Input for Tutor detail page is not TutorDetailArguments',
              settings);
        }
      case bookingDetail:
        if (args is TutorDetailArguments) {
          return successRoute(
              LoadingOverlay(
                  child: BookingDetailPage(tutorModel: args.tutorModel)),
              settings);
        } else {
          return errorRoute(
              'Input for Booking page is not TutorDetailArguments', settings);
        }
      case searchResults:
        if (args is SearchResultArguments) {
          return successRoute(
              LoadingOverlay(
                  child: SearchResultPage(
                nationality: args.nationality,
                searchKey: args.searchKey,
                specialities: args.specialities,
              )),
              settings);
        } else {
          return errorRoute(
              'Input for Search result page is not SearchResultArguments',
              settings);
        }
      //Schedule
      case schedule:
        return successRoute(
            LoadingOverlay(child: const SchedulePage()), settings);
      case joinMeeting:
        if (args is BookingInfoArguments) {
          return successRoute(
              LoadingOverlay(
                  child: JoinMeetingPage(
                upcomingClass: args.upcomingLesson,
              )),
              settings);
        } else {
          return errorRoute(
              'Input for Booking info is not BookingInfoArguments', settings);
        }
      case chatGpt:
        return successRoute(LoadingOverlay(child: JoinMeetingPage()), settings);
      case learningHistory:
        return successRoute(
            LoadingOverlay(child: const LearningHistoryPage()), settings);
      // case analysis:
      //   return successRoute(const AnalysisPage(), settings);
      //Settings
      case setting:
        return successRoute(
            LoadingOverlay(child: const SettingsPage()), settings);
      case becomeTutor:
        return successRoute(
            LoadingOverlay(child: const BecomeTutorPage()), settings);
      case account:
        return successRoute(
            LoadingOverlay(child: const AccountPage()), settings);

      default:
        return errorRoute("No route-name founded", settings);
    }
  }

  static Route<dynamic> errorRoute(String errorMsg, RouteSettings settings) {
    print('Error: $errorMsg');
    return MaterialPageRoute(
        settings: settings,
        builder: (_) => ErrorPage(
              screenName: settings.name,
            ));
  }

  static PageRouteBuilder successRoute(Widget w, RouteSettings settings) {
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (_, __, ___) => w,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, a, __, c) => SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(a),
              child: c,
            ));
  }
}
