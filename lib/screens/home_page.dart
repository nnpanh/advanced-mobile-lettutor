import 'package:flutter/material.dart';
import 'package:lettutor/screens/common_widgets/text_style.dart';

import '../const/custom_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(24, 60, 24, 36),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [CustomColor.shadowBlue, CustomColor.darkBlue],
                        begin: Alignment.topLeft,
                        end: const Alignment(0.75, 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'You have no upcoming lesson.',
                      style: bodyLargeBold(context)
                          ?.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Welcome to LetTutor!',
                      style: bodyLarge(context)?.copyWith(color: Colors.white),
                    )
                  ],
                )),
            Text('Find a tutor',
            style: headLineMedium(context))
          ],
        ),
      ),
    );
  }
}
