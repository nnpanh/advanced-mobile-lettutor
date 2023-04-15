import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lettutor/data/responses/response_get_list_course.dart';

import '../../model/course/course_model.dart';
import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository {
  static const String prefix = "course";

  CourseRepository() : super(prefix);

  Future<void> getCourseListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required Function(List<CourseModel>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "?page=$page&size=$size",
        headers: {
          "Authorization":"Bearer $accessToken"
        }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListCourse.fromJson(response.response).data?.rows??[]);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }


  //TODO: RESPONSE UNKNOWN
  Future<void> getCourseDetailById({
    required String courseId,
    required Function() onSuccess,
  }) async {
    final response = await service.get(
        url: "course/88d8bc4c-3ed2-4c70-b64b-61fff7461712",
    );

    await onSuccess();
  }
}
