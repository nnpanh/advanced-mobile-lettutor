import 'package:flutter/material.dart';

import '../const/const_value.dart';
import '../utils/default_style.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.screenName});

  final String? screenName;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  // AppBar? appBar;
  // Widget? bottomBar;
  //
  // @override
  // void initState() {
  //   appBar = appBarDefault(widget.screenName??"", context);
  //   super.initState();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   getTheme();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(widget.screenName ?? "", context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImagesPath.error),
          const SizedBox(
            height: 16,
          ),
          Text('Oops, something went wrong',
              style: headLineSmall(context)?.copyWith(fontSize: 18)),
        ],
      ),
      // bottomNavigationBar: bottomBar,
    );
  }

// void getTheme() {
//
// switch(widget.screenName) {
// case null:
// appBar = appBarDefault('Unknown page', context);
// break;
// case MyRouter.setting:
// bottomBar = CustomBottomNavigationBar(selectedIndex: NavigationIndex.settingsPage, context: context);
// break;
// case MyRouter.home:
// bottomBar = CustomBottomNavigationBar(selectedIndex: NavigationIndex.settingsPage, context: context);
// break;
// case MyRouter.selectTutorOrCourse:
// bottomBar = CustomBottomNavigationBar(selectedIndex: NavigationIndex.settingsPage, context: context);
// break;
// case MyRouter.schedule:
// bottomBar = CustomBottomNavigationBar(selectedIndex: NavigationIndex.settingsPage, context: context);
// break;
// default:
// break;
// }
// }
}
