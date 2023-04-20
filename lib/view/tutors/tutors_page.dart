import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/config/router.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/data/repositories/tutor_repository.dart';
import 'package:lettutor/data/responses/response_get_list_tutor.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/loading_filled.dart';
import 'package:lettutor/view/tutors/widgets/tutor_card.dart';
import 'package:provider/provider.dart';

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
  int nationalityIndex = 0;
  // list of string options
  late List<String> specialities;
  List<String> nationalities = [
    'All',
    'Foreign Tutor',
    'Vietnamese Tutor',
    'Native English Tutor'
  ];

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
                  value: nationalityIndex,
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
                      nationalityIndex = value;
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
                    callback: () {
                      onSearch(_txtController.text);
                    },
                    buttonType: ButtonType.filledWhiteButton,
                    radius: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearch(String? input) {
    List<String> specKeys = [];
    if (speciality!=0) {
      specKeys.add(specialities[speciality].toLowerCase().replaceAll(' ', '-'));
    }
    String searchKeys = "";
    if (_txtController.text.isNotEmpty) searchKeys = _txtController.text;
    Navigator.pushNamed(context, MyRouter.searchResults,
        arguments:  SearchResultArguments(nationalityIndex, searchKeys, specKeys)
    );
  }

  void resetFilter() {
    if (speciality != 0 ||
        _txtController.text.isNotEmpty ||
        nationalityIndex!=0) {
      setState(() {
        nationalityIndex = 0;
        speciality = 0;
        _txtController.clear();
      });
    }
  }
}
