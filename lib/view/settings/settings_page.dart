import 'package:flutter/material.dart';
import 'package:lettutor/view/settings/widget/menu_widget.dart';
import 'package:lettutor/utils/default_style.dart';
import 'package:lettutor/utils/utils.dart';

import '../../config/router.dart';
import '../../const/const_value.dart';
import '../common_widgets/dialogs/base_dialog/confirm_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 28,
                      backgroundColor: Colors.white,
                      foregroundImage: NetworkImage("https://i.imgur.com/M8p5g08_d.webp?maxwidth=760&fidelity=grand"),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Kimetsu no Yaiba Yaiba Yaiba Yaiba Yaiba Yaiba Yaiba Yaiba Yaiba',
                            style: bodyLargeBold(context)
                                ?.copyWith(color: Colors.white, fontSize: 18),
                            maxLines: 1,
                          ),
                          Text(
                            'Tutor',
                            style: bodyLarge(context)
                                ?.copyWith(color: Colors.white),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          shape: BoxShape.rectangle,
                          // border: Border.all(width: 2, color: Colors.white,)
                      ),
                      child: const Icon(Icons.edit, color: Colors.blue, size: 24,)
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(MyRouter.account);
                    },
                  ),
                  InkWell(
                    child: Container(
                      margin: const EdgeInsets.only(left: 16),
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            shape: BoxShape.rectangle,
                        ),
                        child: const Icon(Icons.logout, color: Colors.blue, size: 24,)
                    ),
                    onTap: () {
                      onPressedLogOut(context, size);
                    },
                  ),
                ],
              )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Account",
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale, fontSize: 18),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  MenuWidget(title: 'Account settings', callback: (){}),
                  MenuWidget(title: 'My wallet', callback: (){}),
                  MenuWidget(title: 'Become a tutor', callback: (){
                    Navigator.of(context).pushNamed(MyRouter.becomeTutor);
                  }),
                  const SizedBox(height: 16,),
                  Text(
                    "Application",
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale, fontSize: 18),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  MenuWidget(title: 'Notifications', callback: (){}),
                  MenuWidget(title: 'Language', callback: (){}),
                  MenuWidget(title: 'Dark mode', callback: (){}),
                  MenuWidget(title: 'Application information', callback: (){}),
                  const SizedBox(height: 16,),
                  Text(
                    "Overview",
                    style: headLineSmall(context)?.copyWith(
                        height: ConstValue.courseNameTextScale, fontSize: 18),
                    textAlign: TextAlign.start,
                    softWrap: true,
                  ),
                  MenuWidget(title: 'Privacy policies', callback: (){}),
                  MenuWidget(title: 'Terms & conditions', callback: (){}),
                  MenuWidget(title: 'Contact for support', callback: (){}),
                  MenuWidget(title: 'FAQs', callback: (){}),
                ],

              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: NavigationIndex.settingsPage, context: context,),
    );
  }

  void onPressedLogOut(BuildContext context, Size size) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialog(
            size: size,
            content: "Do you want to log out?",
            title: 'Logout',
            onRightButton: () {
              pushUntilLogin(context);
            },
            onLeftButton: () {
              Navigator.of(context).pop();
            }, leftButton: 'No', rightButton: 'Yes', hasLeftButton: true,
          );
        });
  }
}
