import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';

import '../../const/export_const.dart';
import '../../model/tutor/tutor_model.dart';
import '../common_widgets/elevated_button.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({super.key});

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  final _txtController = TextEditingController();
  int speciality = 0;
  int nationality = 0;
  int native = 0;
  // list of string options
  late List<String> specialities;
  List<String> nationalities = [
    'All nationalities',
    'Vietnamese',
  ];
  List<String> natives = [
    'Native speaker',
    'Foreign speaker',
  ];

  List<TutorModel> tutorList = [];

  @override
  void initState() {
    specialities = ['All categories'];
    for (var element in Specialities.specialities) {
      specialities.add(element.name!);
    }
    for (var element in Specialities.topics) {
      specialities.add(element.name!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarDefault(AppLocalizations.of(context)!.onlineTutors, context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(AppLocalizations.of(context)!.findATutor,
                        style: headLineSmall(context)),
                    IconButton(
                      onPressed: resetFilter,
                      icon: const Icon(FontAwesomeIcons.filterCircleXmark),
                      iconSize: 18,
                    )
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                controller: _txtController,
                decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.black12,
                    ),
                    contentPadding: const EdgeInsets.all(18),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    hintText: AppLocalizations.of(context)!.enterTutorName,
                    hintStyle: const TextStyle(color: Colors.black12)),
                onChanged: (value) {},
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
              child: Text(AppLocalizations.of(context)!.selectASpeciality,
                  style: headLineSmall(context)),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ChipsChoice<int>.single(
                  value: speciality,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: specialities,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  wrapped: true,
                  choiceStyle: C2ChipStyle.outlined(
                    color: CustomColor.shadowBlue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    selectedStyle: C2ChipStyle.filled(
                        color: Colors.blue, foregroundColor: Colors.white),
                  ),
                  onChanged: (value) {
                    setState(() {
                      speciality = value;
                    });
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.selectNationality,
                      style: headLineSmall(context)),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: ChipsChoice<int>.single(
                  value: nationality,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: nationalities,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  wrapped: true,
                  choiceStyle: C2ChipStyle.outlined(
                    color: CustomColor.shadowBlue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    selectedStyle: C2ChipStyle.filled(
                        color: Colors.blue, foregroundColor: Colors.white),
                  ),
                  onChanged: (value) {
                    setState(() {
                      nationality = value;
                    });
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.selectOrigin,
                      style: headLineSmall(context)),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 16),
              child: ChipsChoice<int>.single(
                  value: native,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: natives,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  wrapped: true,
                  choiceStyle: C2ChipStyle.outlined(
                    color: CustomColor.shadowBlue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    selectedStyle: C2ChipStyle.filled(
                        color: Colors.blue, foregroundColor: Colors.white),
                  ),
                  onChanged: (value) {
                    setState(() {
                      native = value;
                    });
                  }),
            ),

            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 24,
              endIndent: 24,
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: CustomElevatedButton(
                    title: AppLocalizations.of(context)!.search,
                    callback: () {},
                    buttonType: ButtonType.filledWhiteButton,
                    radius: 15),
              ),
            ),
            // const Divider(
            //   color: Colors.grey,
            //   thickness: 1,
            //   indent: 24,
            //   endIndent: 24,
            // ),
            // Container(
            //   alignment: Alignment.topLeft,
            //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            //   child: Text('Matched tutors', style: headLineSmall(context)),
            // ),
            // Container(
            //   padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
            //   child: LimitedBox(
            //       maxHeight: double.maxFinite,
            //       child: ListView.builder(
            //           padding: EdgeInsets.zero,
            //           shrinkWrap: true,
            //           physics: const NeverScrollableScrollPhysics(),
            //           scrollDirection: Axis.vertical,
            //           itemCount: tutorList.length,
            //           itemBuilder: (BuildContext context, int index) {
            //             return TutorCard(
            //               tutorData: tutorList[index],
            //               isFavor: true,
            //               onClickFavorite: () {},
            //             );
            //           })),
            // )
          ],
        ),
      ),
    );
  }

  void onSearch(String? input) {
    print("$input");
  }

  void resetFilter() {
    if (speciality != 0 ||
        _txtController.text.isNotEmpty ||
        nationality != 0 ||
        native != 0) {
      setState(() {
        nationality = 0;
        speciality = 0;
        native = 0;
        _txtController.clear();
      });
    }
  }

  void onClickFavorite() {}
}
