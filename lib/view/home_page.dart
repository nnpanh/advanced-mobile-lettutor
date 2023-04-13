import 'package:flutter/material.dart';
import 'package:lettutor/data/repositories/tutor_repository.dart';
import 'package:lettutor/data/responses/response_get_list_tutor.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/chip_button.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/loading_filled.dart';
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
  final List<TutorModel> _tutorList = [];
  List<String> _favTutorSecondId = [];
  bool _hasFetched = false;


  @override
  Widget build(BuildContext context) {
    if (!_hasFetched) {
      callAPIGetTutorList(1, TutorRepository(), Provider.of<AuthProvider>(context));
    }

    return !_hasFetched
        ? const LoadingFilled()
        : Scaffold(
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
                        return TutorCard(tutorData: _tutorList[index],
                            isFavor: checkIfTutorIsFavored(_tutorList[index]),
                            onClickFavorite: (){
                          onClickFavorite(_tutorList[index]);
                        });
                      })
              )
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

  void onClickFavorite(TutorModel tutorClicked) {
    if (checkIfTutorIsFavored(tutorClicked)) {
      _favTutorSecondId.remove(tutorClicked.userId);
    } else {
      if (tutorClicked.userId != null) {
        _favTutorSecondId.add(tutorClicked.userId!);
        _favTutorSecondId = _favTutorSecondId.toSet().toList();
      }
    }

    //Call API update
    //TODO: LATER
  }

  Future<void> callAPIGetTutorList(int page, TutorRepository tutorRepository, AuthProvider authProvider) async {
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
  }

  void _handleTutorListDataFromAPI(ResponseGetListTutor response) {
    response.favoriteTutor?.forEach((element) {
      if (element.secondId != null) {
        _favTutorSecondId.add(element.secondId!);
      }
    });

    //Separate list
    List<TutorModel> notFavoredList = [];
    List<TutorModel> favoredList = [];
    response.tutors?.rows?.forEach((element) {
      if (checkIfTutorIsFavored(element)) {
        favoredList.add(element);
      } else {
        notFavoredList.add(element);
      }
    });

    //Sort by score
    favoredList.sort((b, a) => (a.rating??0).compareTo((b.rating??0)));
    notFavoredList.sort((b, a) => (a.rating??0).compareTo((b.rating??0)));

    //Add to final list
    _tutorList.addAll(favoredList);
    _tutorList.addAll(notFavoredList);
  }

  bool checkIfTutorIsFavored(TutorModel tutor) {
    for (var element in _favTutorSecondId) {
      if (element.compareTo(tutor.userId!) == 0) return true;
    }
    return false;
  }
}
