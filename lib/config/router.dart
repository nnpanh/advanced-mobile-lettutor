import 'package:flutter/material.dart';
import 'package:lettutor/screens/courses.dart';
import 'package:lettutor/screens/login_page.dart';

import '../screens/home_page.dart';

class HomeArguments {
  final String title;

  const HomeArguments({required this.title});
}


class MyRouter {
  static const String home = 'home';
  static const String courses = 'courses';
  static const String login ='login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case courses:
        return MaterialPageRoute(builder: (_) => const CoursesPage(counter: 0));
      case home:
        if (args is HomeArguments) {
          return MaterialPageRoute(
              builder: (_) => HomePage(title: args.title),
              settings:
                  RouteSettings(name: home, arguments: settings.arguments));
        } else {
          return errorRoute("Input for Home is not HomeArguments");
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
}

