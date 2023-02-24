import 'package:flutter/material.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/utils/utils.dart';

import '../config/router.dart';

class DefaultColor {
  late Color fontColor = Colors.black;
  late Color backgroundColor = Colors.transparent;

  DefaultColor() {
    if (getDeviceThemeMode() == ThemeMode.light) {
      fontColor = Colors.black;
      backgroundColor = Colors.transparent;
    } else {
      fontColor = Colors.white;
      backgroundColor = Colors.black;
    }
  }
}

AppBar appBar(String title, BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Theme.of(context).primaryColor,
    titleSpacing: 0,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          pushNamedAndRemoveUntilHome(context);
        },
      )
    ],
  );
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key, required this.selectedIndex, required this.context});
  final int selectedIndex;
  final BuildContext context;


  void _onItemTapped(int index) {
      switch(index){
        case NavigationIndex.coursesPage:
          pushNamedAndRemoveUntilHome(context,newRoute: MyRouter.courses);
          break;
        case NavigationIndex.homePage:
          pushNamedAndRemoveUntilHome(context,newRoute: MyRouter.home);
          break;
        case NavigationIndex.settingsPage:
          pushNamedAndRemoveUntilHome(context,newRoute: MyRouter.login);
          break;
        case NavigationIndex.tutorsPage:
          pushNamedAndRemoveUntilHome(context,newRoute: MyRouter.tutors);
          break;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), topLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
        borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25.0),
    topRight: Radius.circular(25.0),
    ),
    child:
    BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_edu),
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Tutor',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
    ))
      );
  }
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w400,
      color: DefaultColor().fontColor,
      backgroundColor: DefaultColor().backgroundColor);
}

TextStyle? bodyLargeBold(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      color: DefaultColor().fontColor,
      backgroundColor: DefaultColor().backgroundColor);
}

TextStyle? headLineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w500,
      color: DefaultColor().fontColor,
      backgroundColor: DefaultColor().backgroundColor);
}

TextStyle? headLineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w500,
      color: DefaultColor().fontColor,
      backgroundColor: DefaultColor().backgroundColor);
}
