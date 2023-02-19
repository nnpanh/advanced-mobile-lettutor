import 'package:flutter/material.dart';

import '../screens/home.dart';

class HomeArguments {
  final String title;
  final int number;

  const HomeArguments({required this.title, required this.number});
}


class MyRouter {
  static const String home = 'home';
  static const String splash = '/';
  static const String login = 'login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;
    switch (settings.name) {
      case splash:
        // return MaterialPageRoute(builder: (_) => const MyHomePage(title: 'Splash',counter: 0));
      case home:
        if (args is HomeArguments) {
          return MaterialPageRoute(
              builder: (_) => MyHomePage(title: args.title, counter: args.number),
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

