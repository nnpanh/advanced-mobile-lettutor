import 'package:flutter/material.dart';
import 'package:lettutor/model/tutor_model.dart';
import 'package:lettutor/screens/authentication/forgot_pass_page.dart';
import 'package:lettutor/screens/authentication/login_page.dart';
import 'package:lettutor/screens/authentication/sign_up_page.dart';

import '../screens/courses/course_page.dart';
import '../screens/tutors/book_tutor_page.dart';
import '../screens/tutors/home_page.dart';
import '../screens/tutors/tutor_detail_page.dart';

class TutorDetailArguments {
  final TutorModel tutorModel;

  const TutorDetailArguments({required this.tutorModel});
}

class MyRouter {
  static const String home = 'home';
  static const String courses = 'courses';
  static const String login = 'login';
  static const String signUp = 'signUp';
  static const String forgotPassword = 'forgotPassword';
  static const String tutorDetail = 'tutorDetail';
  static const String bookTutor = 'bookTutor';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case forgotPassword:
        return successRoute(const ForgotPasswordPage(), settings);
      case login:
        return successRoute(const LoginPage(), settings);

      case signUp:
        return successRoute(const SignUpPage(), settings);

      case courses:
        return successRoute(const CoursePage(), settings);
      case home:
        return successRoute(const HomePage(), settings);
      case tutorDetail:
        if (args is TutorDetailArguments) {
          return successRoute(
              TutorDetailPage(tutorModel: args.tutorModel), settings);
        } else {
          return errorRoute(
              'Input for Tutor detail page is not TutorDetailArguments');
        }
      case bookTutor:
        if (args is TutorDetailArguments) {
          return successRoute(
              BookTutorPage(tutorModel: args.tutorModel), settings);
        } else {
          return errorRoute(
              'Input for Book t page is not TutorDetailArguments');
        }
      default:
        return errorRoute("No route-name founded");
    }
  }

  //todo: define 404 screen here, log
  static Route<dynamic> errorRoute(String errorMsg) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('Error in routing: $errorMsg'),
              ),
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
