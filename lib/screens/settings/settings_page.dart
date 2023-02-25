import 'package:flutter/material.dart';
import 'package:lettutor/utils/default_style.dart';

import '../../const/const_value.dart';
import '../../const/custom_color.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.fromLTRB(24, 60, 24, 36),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,),
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
                      padding: EdgeInsets.only(left: 16),
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
                    onTap: () {},
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
                    onTap: () {},
                  ),
                ],
              )),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(selectedIndex: NavigationIndex.settingsPage, context: context,),
    );
  }
}
