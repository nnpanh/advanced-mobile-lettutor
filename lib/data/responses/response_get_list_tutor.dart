import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/tutor/tutor_extracted_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

import '../../model/tutor/favorite_tutor.dart';

part 'response_get_list_tutor.g.dart';

@JsonSerializable()
class ResponseGetListTutor {
  TutorPagination? tutors;
  List<FavoriteTutor>? favoriteTutor;

  ResponseGetListTutor({
    this.tutors,
    this.favoriteTutor
  });

  factory ResponseGetListTutor.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListTutorFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListTutorToJson(this);
}


@JsonSerializable()
class TutorPagination {
  int? count;
  List<TutorModel>? rows;

  TutorPagination({
    this.count,
    this.rows,
  });

  factory TutorPagination.fromJson(Map<String, dynamic> json) =>
      _$TutorPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$TutorPaginationToJson(this);
}

