import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

import '../../const/const_value.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          child: ClipPath(
              clipper: Triangle(),
              child: Container(
                  padding: EdgeInsets.only(left: 16, bottom: size.height * 0.2),
                  height: size.height + 56,
                  width: size.width,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.people_alt_outlined,
                        color: Colors.white,
                        size: 48,
                      ),
                      Text(
                        AppLocalizations.of(context)!.tutor,
                        style: headLineMedium(context)
                            ?.copyWith(color: Colors.white),
                      ),
                      SizedBox(
                        width: size.width * 0.4,
                        child: Text(
                          AppLocalizations.of(context)!.tutorDescription,
                          style: bodyLarge(context)?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ))),
          onTap: () {
            Navigator.of(context).pushNamed(MyRouter.tutors);
          },
        ),
        GestureDetector(
          child: ClipPath(
              clipper: ReverseTriangle(),
              child: Container(
                  padding: EdgeInsets.only(right: 16, top: size.height * 0.2),
                  height: size.height + 56,
                  width: size.width,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.history_edu,
                        color: Colors.blue,
                        size: 48,
                      ),
                      Text(
                        AppLocalizations.of(context)!.course,
                        style: headLineMedium(context)
                            ?.copyWith(color: Colors.blue),
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          AppLocalizations.of(context)!.courseDescription,
                          style: bodyLarge(context)?.copyWith(
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      )
                    ],
                  ))),
          onTap: () {
            Navigator.of(context).pushNamed(MyRouter.courses);
          },
        ),
        Container(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavigationBar(
                selectedIndex: NavigationIndex.studyPage, context: context))
      ],
    );
  }
}

class Triangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ReverseTriangle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
