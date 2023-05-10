import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/data/repositories/tutor_repository.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';
import 'package:lettutor/providers/auth_provider.dart';
import 'package:lettutor/view/common_widgets/circle_network_image.dart';
import 'package:lettutor/view/common_widgets/dialogs/report_dialog.dart';
import 'package:lettutor/view/common_widgets/loading_filled.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:video_player/video_player.dart';

import '../../config/router.dart';
import '../../config/router_arguments.dart';
import '../../const/export_const.dart';
import '../common_widgets/default_style.dart';
import '../common_widgets/dialogs/show_reviews_dialog.dart';
import '../common_widgets/elevated_button.dart';
import '../common_widgets/title_and_chips.dart';

class TutorDetailPage extends StatefulWidget {
  const TutorDetailPage({super.key, required this.tutorModel});
  final TutorModel tutorModel;

  @override
  State<TutorDetailPage> createState() => _TutorDetailPageState();
}

class _TutorDetailPageState extends State<TutorDetailPage> {
  late TutorModel tutorData;
  late TutorInfo tutorInfo;
  late VideoPlayerController _controller;
  bool _hasFetch = false;

  @override
  void initState() {
    tutorData = widget.tutorModel;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (!_hasFetch) {
      callAPIGetTutorById(TutorRepository(), Provider.of<AuthProvider>(context),
          tutorData.userId);
    }

    return Scaffold(
        appBar:
            appBarDefault(AppLocalizations.of(context)!.tutorDetails, context),
        body: !_hasFetch
            ? const LoadingFilled()
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white30,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: CircleNetworkImage(
                                  url: tutorData.avatar, size: 80.0),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 12, 16, 12),
                                  child: Text(
                                    "${tutorData.name}",
                                    style: bodyLargeBold(context)?.copyWith(
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "${tutorData.country}",
                                    style: bodyLarge(context)
                                        ?.copyWith(color: Colors.black38),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 12),
                                  child: RatingBar(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    glow: false,
                                    ignoreGestures: true,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    itemSize: 24,
                                    onRatingUpdate: (double value) {},
                                    ratingWidget: RatingWidget(
                                      full: const Icon(Icons.star,
                                          color: Colors.amber),
                                      empty: const Icon(Icons.star_border,
                                          color: Colors.amber),
                                      half: const Icon(Icons.star_half,
                                          color: Colors.amber),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: ReadMoreText(
                          "${tutorData.bio}",
                          trimLines: 4,
                          textAlign: TextAlign.justify,
                          style: bodyLarge(context)?.copyWith(
                            color: CustomColor.greyTextColor,
                          ),
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText:
                              AppLocalizations.of(context)!.showMore,
                          trimExpandedText:
                              AppLocalizations.of(context)!.showLess,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (tutorInfo.isFavorite != null) {
                                      tutorInfo.isFavorite =
                                          !tutorInfo.isFavorite!;
                                    }
                                  });
                                },
                                icon: tutorInfo.isFavorite == false
                                    ? const Icon(
                                        Icons.favorite_border,
                                        color: Colors.blue,
                                      )
                                    : const Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent,
                                      ),
                                padding: const EdgeInsets.all(8),
                              ),
                              Text(AppLocalizations.of(context)!.favorite,
                                  style: bodyLarge(context)
                                      ?.copyWith(color: Colors.blue))
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  onPressedReport(size, tutorData.name, context,
                                      tutorData.id ?? "");
                                },
                                icon: const Icon(
                                  Icons.report_outlined,
                                  color: Colors.blue,
                                ),
                                padding: const EdgeInsets.all(8),
                              ),
                              Text(AppLocalizations.of(context)!.report,
                                  style: bodyLarge(context)
                                      ?.copyWith(color: Colors.blue))
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  onPressedShowReviews(
                                      size, context, tutorData.feedbacks ?? []);
                                },
                                icon: const Icon(
                                  Icons.reviews_outlined,
                                  color: Colors.blue,
                                ),
                                padding: const EdgeInsets.all(8),
                              ),
                              Text(AppLocalizations.of(context)!.reviews,
                                  style: bodyLarge(context)
                                      ?.copyWith(color: Colors.blue))
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: InkWell(
                          onTap: () {
                            if (_controller.value.isPlaying) {
                              _controller.pause();
                            } else {
                              _controller.play();
                            }
                          },
                          child: LimitedBox(
                            maxHeight: size.height * 0.4,
                            child: Container(
                              color: Colors.black87,
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TitleAndChips(
                          input: tutorInfo.languages ?? "en",
                          title: AppLocalizations.of(context)!.languages,
                          type: TutorDetailListType.languages),
                      TitleAndChips(
                        input: tutorInfo.specialties ?? "",
                        title: AppLocalizations.of(context)!.specialities,
                        type: TutorDetailListType.specialities,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(AppLocalizations.of(context)!.interests,
                            style: headLineSmall(context)),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: ReadMoreText(
                          "${tutorInfo.interests?.trim()}",
                          trimLines: 20,
                          textAlign: TextAlign.justify,
                          style: bodyLarge(context)?.copyWith(
                            color: CustomColor.greyTextColor,
                          ),
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText:
                              AppLocalizations.of(context)!.showMore,
                          trimExpandedText:
                              AppLocalizations.of(context)!.showLess,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Text(
                            AppLocalizations.of(context)!.teachingExperience,
                            style: headLineSmall(context)),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                        child: ReadMoreText(
                          "${tutorInfo.experience?.trim()}",
                          trimLines: 20,
                          textAlign: TextAlign.justify,
                          style: bodyLarge(context)?.copyWith(
                            color: CustomColor.greyTextColor,
                          ),
                          colorClickableText: Colors.blue,
                          trimMode: TrimMode.Line,
                          trimCollapsedText:
                              AppLocalizations.of(context)!.showMore,
                          trimExpandedText:
                              AppLocalizations.of(context)!.showLess,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          child: CustomElevatedButton(
                              title:
                                  AppLocalizations.of(context)!.bookThisTutor,
                              buttonType: ButtonType.filledButton,
                              callback: () {
                                _controller.pause();
                                Navigator.pushNamed(
                                    context, MyRouter.bookingDetail,
                                    arguments: TutorDetailArguments(
                                        tutorModel: tutorData));
                              },
                              radius: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }

  Future<void> callAPIGetTutorById(TutorRepository tutorRepository,
      AuthProvider authProvider, String? userId) async {
    await tutorRepository.getTutorById(
        accessToken: authProvider.token?.access?.token ?? "",
        tutorId: userId ?? "",
        onSuccess: (response) async {
          setState(() {
            tutorInfo = response;
            _hasFetch = true;
          });
          //Play video
          _controller = VideoPlayerController.network(tutorInfo.video ?? "");

          _controller.addListener(() {
            setState(() {});
          });
          _controller.setLooping(true);
          _controller.initialize().then((_) => setState(() {}));
          _controller.play();
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        });
  }
}
