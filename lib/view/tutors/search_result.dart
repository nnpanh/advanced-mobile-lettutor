import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lettutor/config/router.dart';
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

class SearchResultPage extends StatefulWidget {
  const SearchResultPage({super.key, required this.nationality, required this.searchKey, required this.specialities});
  final int nationality;
  final String searchKey;
  final List<String> specialities;

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  //Search result
  final List<TutorModel> _tutorList = [];
  bool _hasFetched = false;
  late Map<String, dynamic> nationalityInput;

  @override
  void initState() {
    super.initState();
    switch(widget.nationality){
      case Nationality.nationForeign:
        nationalityInput = {
          "isVietNamese": false,
          "isNative": false
        };
        break;
      case Nationality.nationAll:
        nationalityInput = {
        };
        break;
      case Nationality.nationVN:
        nationalityInput = {
          "isVietNamese": true,
          "isNative": false
        };
        break;
      case Nationality.nationNative:
        nationalityInput = {
          "isNative": true
        };
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasFetched) {
      callAPISearchTutor(TutorRepository(), Provider.of<AuthProvider>(context));
    }

    return !_hasFetched
        ? const LoadingFilled()
        : Scaffold(
      appBar:
          appBarDefault(MyRouter.searchResults, context),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text('Matched tutors', style: headLineSmall(context)),
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
                          hasFavor: false,
                          tutorData: _tutorList[index],
                          isFavor: _tutorList[index].tutorInfo?.isFavorite ?? false,
                          onClickFavorite: () {},
                        );
                      })),
            )
          ],
        ),
      ),
    );
  }

  Future<void> callAPISearchTutor(TutorRepository tutorRepository,
      AuthProvider authProvider) async {
    await tutorRepository.searchTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        searchKeys: widget.searchKey,
        speciality: widget.specialities,
        nationality: {},
        onSuccess: (response) async {
          _tutorList.addAll(response);
          setState(() {
            _hasFetched = true;
          });
        },
        onFail: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.toString()}')),
          );
        },

    );
  }

}
