import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository {
  static const String prefix = "course/";

  CourseRepository() : super(prefix);

  //TODO: RESPONSE UNKNOWN
  Future<void> getCourseListWithPagination({
    required int page,
    required int size,
    required Function() onSuccess,
  }) async {
    final response = await service.get(
        url: "course?page=1&size=100",
    );

    await onSuccess();
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
