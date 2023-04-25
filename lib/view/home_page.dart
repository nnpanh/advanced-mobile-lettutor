import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lettutor/config/router_arguments.dart';
import 'package:lettutor/data/repositories/tutor_repository.dart';
import 'package:lettutor/data/responses/response_get_list_tutor.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/chip_button.dart';
import 'package:lettutor/view/common_widgets/default_style.dart';
import 'package:lettutor/view/common_widgets/loading_filled.dart';
import 'package:lettutor/view/tutors/widgets/tutor_card.dart';
import 'package:provider/provider.dart';

import '../config/router.dart';
import '../const/export_const.dart';
import '../data/repositories/booking_repository.dart';
import '../model/tutor/tutor_model.dart';
import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Tutor list
  final List<TutorModel> _tutorList = [];
  List<String> _favTutorSecondId = [];

  //Upcoming lesson data
  List<BookingInfo> lessonList = [];
  double totalLessonTime = 0.0;
  BookingInfo? upcomingLesson;

  //Fetch API
  bool _hasFetched = false;


  @override
  Widget build(BuildContext context) {
    if (!_hasFetched) {
      var authProvider = Provider.of<AuthProvider>(context);
      //Fetch API
      callAPIGetTutorList(1, TutorRepository(), authProvider);
      callApiGetListSchedules(BookingRepository(), authProvider);
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
                            AppLocalizations.of(context)!.upComingLesson,
                            style: bodyLargeBold(context)
                                ?.copyWith(color: Colors.white, fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child:
                            (upcomingLesson != null)?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    getDateString(DateTime.fromMillisecondsSinceEpoch(upcomingLesson!.scheduleDetailInfo!.startPeriodTimestamp!),
                                        TimeFormat.getDateAndTime),
                                    style: bodyLarge(context)
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: ChipButton(
                                      callback: () {
                                        joinUpcomingMeeting(context);
                                      },
                                      title: AppLocalizations.of(context)!.join,
                                      hasIcon: false,
                                      chipType: ButtonType.filledWhiteButton,
                                    ))
                              ],
                            ): const SizedBox(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                              (totalLessonTime==0.0)? AppLocalizations.of(context)!.noUpcomingLesson:
                            "${AppLocalizations.of(context)!.totalLearningHoursLeft}: ${totalLessonTime.toStringAsFixed(2)}",
                            style: bodyLarge(context)
                                ?.copyWith(color: Colors.white),
                          ),
                        ],
                      )),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                    child: Text(AppLocalizations.of(context)!.recommendTutors,
                        style: headLineMedium(context)),
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
                                return TutorCard(
                                  hasFavor: true,
                                    tutorData: _tutorList[index],
                                    isFavor: checkIfTutorIsFavored(
                                        _tutorList[index]),
                                    onClickFavorite: () {
                                      onClickFavorite(_tutorList[index]);
                                    });
                              })))
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
  }

  Future<void> callAPIGetTutorList(int page, TutorRepository tutorRepository,
      AuthProvider authProvider) async {
    await tutorRepository.getListTutor(
        accessToken: authProvider.token?.access?.token ?? "",
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
    favoredList.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));
    notFavoredList.sort((b, a) => (a.rating ?? 0).compareTo((b.rating ?? 0)));

    //Add to final list
    _tutorList.addAll(favoredList);
    _tutorList.addAll(notFavoredList);
  }

  bool checkIfTutorIsFavored(TutorModel tutor) {
    for (var element in _favTutorSecondId) {
      if (element == tutor.userId) return true;
    }
    return false;
  }

  Future<void> callApiGetListSchedules(BookingRepository bookingRepository, AuthProvider authProvider) async {
    await bookingRepository.getUpcomingLessonAtHomePage(
        accessToken: authProvider.token?.access?.token ?? "",
        now: DateTime.now().millisecondsSinceEpoch,
        onSuccess: (response) async {
          _filterListScheduleFromApi(response);
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }

  void _filterListScheduleFromApi(List<BookingInfo> listBooking) {
    for (var value in listBooking) {
      if (value.isDeleted != true) {
        lessonList.insert(0, value);
      }
    }

    double totalTime = 0.0;
    for (var element in lessonList) {
      var lessonDuration = DateTime.fromMillisecondsSinceEpoch(element.scheduleDetailInfo!.endPeriodTimestamp!).difference(DateTime.fromMillisecondsSinceEpoch(element.scheduleDetailInfo!.startPeriodTimestamp!));
      var minutesValue = double.parse((lessonDuration.inMinutes/60).toStringAsFixed(2));
      totalTime = totalTime + lessonDuration.inHours + minutesValue;
    }

    setState(() {
      upcomingLesson = lessonList.first;
      totalLessonTime = totalTime;
      _hasFetched = true;
    });
  }

  void joinUpcomingMeeting(BuildContext context) {
    Navigator.of(context).pushNamed(MyRouter.joinMeeting, arguments: BookingInfoArguments(upcomingLesson: upcomingLesson!));
  }
}
