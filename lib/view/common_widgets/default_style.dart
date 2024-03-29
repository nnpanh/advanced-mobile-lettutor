import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:lettutor/const/const_value.dart';
import 'package:lettutor/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../config/router.dart';
import '../../providers/settings_provider.dart';

class DefaultColor {
  late Color fontColor = Colors.black;
  late Color backgroundColor = Colors.transparent;

  DefaultColor(BuildContext context) {
    var colorTheme = Provider.of<SettingsProvider>(context).themeMode;
    if (colorTheme == ThemeMode.light) {
      fontColor = Colors.black;
      backgroundColor = Colors.transparent;
    } else {
      fontColor = Colors.white;
      backgroundColor = Colors.transparent;
    }
  }
}

AppBar appBarWithCustomAction(
    String title, BuildContext context, Widget action) {
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
    actions: <Widget>[action],
  );
}

AppBar appBarDefault(String title, BuildContext context) {
  return appBarWithCustomAction(
      title,
      context,
      IconButton(
        icon: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        onPressed: () {
          popUntilHome(context);
        },
      ));
}

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.selectedIndex, required this.context});
  final int selectedIndex;
  final BuildContext context;

  void _onItemTapped(int index) {
    if (index == selectedIndex) return;
    switch (index) {
      case NavigationIndex.schedulePage:
        pushNamedAndRemoveUntilHome(context, newRoute: MyRouter.schedule);
        break;
      case NavigationIndex.homePage:
        pushNamedAndRemoveUntilHome(context, newRoute: MyRouter.home);
        break;
      case NavigationIndex.settingsPage:
        pushNamedAndRemoveUntilHome(context, newRoute: MyRouter.setting);
        break;
      case NavigationIndex.studyPage:
        pushNamedAndRemoveUntilHome(context,
            newRoute: MyRouter.selectTutorOrCourse);
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
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)?.home,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.timer_sharp),
                  label: AppLocalizations.of(context)?.schedule,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.school),
                  label: AppLocalizations.of(context)?.study,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)?.settings,
                ),
              ],
              currentIndex: selectedIndex,
              unselectedItemColor: Colors.black54,
              selectedItemColor: Colors.blue,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
            )));
  }
}

TextStyle? bodyLarge(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w400,
      height: ConstValue.descriptionTextScale,
      color: DefaultColor(context).fontColor,
      backgroundColor: DefaultColor(context).backgroundColor);
}

TextStyle? bodyLargeBold(BuildContext context) {
  return Theme.of(context).textTheme.bodyLarge?.copyWith(
      fontWeight: FontWeight.w500,
      height: ConstValue.descriptionTextScale,
      color: DefaultColor(context).fontColor,
      backgroundColor: DefaultColor(context).backgroundColor);
}

TextStyle? headLineSmall(BuildContext context) {
  return Theme.of(context).textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.w500,
      height: ConstValue.descriptionTextScale,
      color: DefaultColor(context).fontColor,
      backgroundColor: DefaultColor(context).backgroundColor);
}

TextStyle? headLineMedium(BuildContext context) {
  return Theme.of(context).textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w500,
      height: ConstValue.descriptionTextScale,
      color: DefaultColor(context).fontColor,
      backgroundColor: DefaultColor(context).backgroundColor);
}

PaginateButtonStyles paginationStyle(BuildContext context) {
  return PaginateButtonStyles(
      backgroundColor: Colors.white,
      activeBackgroundColor: Colors.blue,
      textStyle: bodyLarge(context)?.copyWith(color: Colors.blue),
      activeTextStyle: bodyLarge(context)?.copyWith(color: Colors.white));
}

PaginateSkipButton prevButtonStyles(BuildContext context) {
  return PaginateSkipButton(
      icon: const Icon(
        Icons.navigate_before,
        color: Colors.blue,
      ),
      buttonBackgroundColor: Colors.white,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)));
}

PaginateSkipButton nextButtonStyles(BuildContext context) {
  return PaginateSkipButton(
      icon: const Icon(
        Icons.navigate_next,
        color: Colors.blue,
      ),
      buttonBackgroundColor: Colors.white,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16), bottomRight: Radius.circular(16)));
}
