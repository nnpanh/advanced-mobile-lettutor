import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/view/tutors/widgets/tutor_card.dart';
import 'package:lettutor/utils/default_style.dart';

import '../../config/router.dart';
import '../../const/export_const.dart';
import '../../model/tutor_model.dart';
import '../../utils/utils.dart';

class TutorsPage extends StatefulWidget {
  const TutorsPage({super.key});

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  int speciality = 0;
  final _txtController = TextEditingController();

  // list of string options
  late List<String> specialities;
  // List<String> specialities = [
  //   'All categories',
  //   'English for kids',
  //   'English for Business',
  //   'Conversational',
  //   'Starters',
  //   'Movers',
  //   'Flyers',
  //   'KET/PET',
  //   'TOEIC',
  //   'IELTS',
  //   'TOEFL',
  // ];

  int nationality = 0;
  List<String> nationalities = [
    'All nationalities',
    'Vietnamese',
    'Native speaker',
    'Foreign speaker',
  ];

  List<TutorModel> tutorList = generateTutorList();

  @override
  void initState() {
    specialities = ['All categories'];
    specialities.addAll(ConstValue.specialityList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(MyRouter.tutors, context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
              child: Text('Find a tutor',
                  style: headLineMedium(context)?.copyWith(fontSize: 32)),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                controller: _txtController,
                decoration: const InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black12,
                    ),

                    contentPadding: EdgeInsets.all(18),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    ),
                    hintText: 'Enter tutor name',
                    hintStyle: TextStyle(color: Colors.black12)),
                onChanged: (value) {
                  onSearch("$value");
                },
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Select a specialities', style: headLineSmall(context)),
                  IconButton(
                    onPressed: resetFilter,
                    icon: const Icon(FontAwesomeIcons.filterCircleXmark),
                    iconSize: 18,
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: ChipsChoice<int>.single(
                  value: speciality,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: specialities,
                    value: (i, v) => i,
                    label: (i, v) => v,
                    // tooltip: (i, v) => v,
                  ),
                  wrapped: true,
                  // choiceCheckmark: true,
                  choiceStyle: C2ChipStyle.outlined(
                    color: CustomColor.shadowBlue,
                    // color: Theme.of(context).primaryColor,
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
                  Text('Select nationality', style: headLineSmall(context)),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
              child: ChipsChoice<int>.single(
                  value: nationality,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: nationalities,
                    value: (i, v) => i,
                    label: (i, v) => v,
                    // tooltip: (i, v) => v,
                  ),
                  wrapped: true,
                  // choiceCheckmark: true,
                  choiceStyle: C2ChipStyle.outlined(
                    color: CustomColor.shadowBlue,
                    // color: Theme.of(context).primaryColor,
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
            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 36,
              endIndent: 36,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text('Matched tutors', style: headLineMedium(context)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: LimitedBox(
                  maxHeight: double.maxFinite,
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: tutorList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TutorCard(tutorData: tutorList[index]);
                      })),
            )
            // Container(
            //   child: tutorList()
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
    if (speciality != 0 || _txtController.text.isNotEmpty || nationality != 0) {
      setState(() {
        nationality = 0;
        speciality = 0;
        _txtController.clear();
      });
    }
  }

  void onClickFavorite() {}
}
