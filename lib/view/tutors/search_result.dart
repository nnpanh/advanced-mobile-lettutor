import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
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
import '../../utils/utils.dart';
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
  List<TutorModel> _tutorList = [];
  bool _hasFetched = false;
  late Map<String, dynamic> nationalityInput;

  //Pagination
  bool _loading = true;
  final int perPage = 5;
  int currentPage = 1;
  int maximumPage = 1;
  int numberOfShowPages = 0;


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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      callAPISearchTutor(1,TutorRepository(), Provider.of<AuthProvider>(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
            !_loading?
            _tutorList.isNotEmpty? Container(
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
            ): SizedBox(
              height: size.height * 0.5,
              child: Center(
                child: Text("No tutor found",
                    style: bodyLarge(context)
                        ?.copyWith(color: Colors.black45)),
              ),
            ) : SizedBox(
              height: size.height * 0.8,
              child: const Center(child: CircularProgressIndicator()),
            ),
            Container(
              alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Pagination(
                  paginateButtonStyles: paginationStyle(context),
                  prevButtonStyles: prevButtonStyles(context),
                  nextButtonStyles: nextButtonStyles(context),
                  onPageChange: (number) {
                    setState(() {
                      _loading = true;
                      currentPage = number;
                    });
                    //Call API
                    callAPISearchTutor(number,
                        TutorRepository(), authProvider);
                  },
                  useGroup: false,
                  totalPage: maximumPage,
                  show: numberOfShowPages,
                  currentPage: currentPage,
                ))
          ],
        ),
      ),
    );
  }

  Future<void> callAPISearchTutor(int page, TutorRepository tutorRepository,
      AuthProvider authProvider) async {
    await tutorRepository.searchTutor(
        accessToken: authProvider.token?.access?.token ?? "",
        searchKeys: widget.searchKey,
        speciality: widget.specialities,
        nationality: {},page: page,
        onSuccess: (response, total) async {
          _tutorList = [];
          _tutorList.addAll(response);
          currentPage = page;
          maximumPage = (total / perPage).ceil();
          numberOfShowPages = getShowPagesBasedOnPages(maximumPage);
          setState(() {
            _hasFetched = true;
            _loading = false;
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
