import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/tutors/widgets/tutor_card.dart';

import '../const/export_const.dart';
import '../model/tutor_model.dart';
import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tag = 0;
  final _txtController = TextEditingController();

  // list of string options
  List<String> options = [
    'All categories',
    'English for kids',
    'English for Business',
    'Conversational',
    'Starters',
    'Movers',
    'Flyers',
    'KET/PET',
    'TOEIC',
    'IELTS',
    'TOEFL',
  ];

  List<TutorModel> tutorList = generateTutorList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  value: tag,
                  choiceItems: C2Choice.listFrom<int, String>(
                    source: options,
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
                      tag = value;
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
              child: Text('Recommed tutors', style: headLineMedium(context)),
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
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: NavigationIndex.homePage,
        context: context,
      ),
    );
  }

  void onSearch(String? input) {
    print("$input");
  }

  void resetFilter() {
    if (tag != 0 || _txtController.text.isNotEmpty) {
      setState(() {
        tag = 0;
        _txtController.clear();
      });
    }
  }

  void onClickFavorite() {}
}
