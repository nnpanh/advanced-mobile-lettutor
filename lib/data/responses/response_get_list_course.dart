import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/model/tutor/tutor_extracted_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

import '../../model/tutor/favorite_tutor.dart';

part 'response_get_list_course.g.dart';

@JsonSerializable()
class ResponseGetListCourse {
  String? message;
  CoursePagination? data;

  ResponseGetListCourse({
    this.message,
    this.data,
  });

  factory ResponseGetListCourse.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListCourseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListCourseToJson(this);
}


@JsonSerializable()
class CoursePagination {
  int? count;
  List<CourseModel>? rows;

  CoursePagination({
    this.count,
    this.rows,
  });

  factory CoursePagination.fromJson(Map<String, dynamic> json) =>
      _$CoursePaginationFromJson(json);
  Map<String, dynamic> toJson() => _$CoursePaginationToJson(this);
}

