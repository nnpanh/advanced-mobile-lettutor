import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/data/repositories/tutor_repository.dart';
import 'package:lettutor/data/responses/response_get_list_tutor.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/chip_button.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/tutors/widgets/tutor_card.dart';
import 'package:provider/provider.dart';

import '../config/router.dart';
import '../const/export_const.dart';
import '../model/tutor/tutor_model.dart';
import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tag = 0;
  final _txtController = TextEditingController();
  List<TutorModel> _tutorList = [];
  List<String> _favTutor = [];
  bool _hasFetched = false;

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

  @override
  Widget build(BuildContext context) {
    if (!_hasFetched) {
      callAPIGetTutorList(1, TutorRepository(), Provider.of<AuthProvider>(context));
    }

    return !_hasFetched?  Container(
      color: Colors.white,
        constraints: const BoxConstraints.expand(),
        child: const Center(child: CircularProgressIndicator())
    ):
    Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 36),
                width: double.infinity,
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Lesson',
                      style: bodyLargeBold(context)
                          ?.copyWith(color: Colors.white, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              getDateString(
                                  DateTime.now(), TimeFormat.getDateAndTime),
                              style: bodyLarge(context)
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: ChipButton(
                                callback: () {
                                  Navigator.of(context)
                                      .pushNamed(MyRouter.joinMeeting);
                                },
                                title: '  Join  ',
                                hasIcon: false,
                                chipType: ButtonType.filledWhiteButton,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Total learning hours left: 4 hours',
                      style: bodyLarge(context)?.copyWith(color: Colors.white),
                    ),
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
                  onSearch(value);
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
              child: Text('Recommend tutors', style: headLineMedium(context)),
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
                      itemCount: _tutorList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TutorCard(tutorData: _tutorList[index]);
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

  Future<void> callAPIGetTutorList(int page, TutorRepository tutorRepository, AuthProvider authProvider) async {
    try {
      await tutorRepository.getListTutor(
        accessToken: authProvider.token?.access?.token??"",
        page: page,
          perPage: 10,
          onSuccess: (response) async {
          _handleTutorListDataFromAPI(response);
          setState(() {
            _hasFetched = true;
          });
          },
          onFail: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${error.toString()}')),
            );
          });
    } finally {
    }
  }

  void _handleTutorListDataFromAPI(ResponseGetListTutor response) {
    response.favoriteTutor?.forEach((element) {
      if (element.secondId != null) {
        _favTutor.add(element.secondId!);
      }
    });
      _tutorList.addAll(response.tutors?.rows??[]);
  }
}
