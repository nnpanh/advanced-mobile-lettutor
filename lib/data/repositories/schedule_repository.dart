import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lettutor/data/responses/response_get_list_course.dart';
import 'package:lettutor/model/schedule/schedule.dart';

import '../../model/course/course_model.dart';
import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import '../responses/response_get_list_schedule.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class ScheduleRepository extends BaseRepository {
  static const String prefix = "schedule";

  ScheduleRepository() : super(prefix);

  Future<void> getScheduleById({
    required String accessToken,
    required String tutorId,
    required int startTime,
    required int endTime,
    required Function(List<Schedule>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "?tutorId=$tutorId&startTimestamp=$startTime&endTimestamp=$endTime&=",
        headers: {
          "Authorization":"Bearer $accessToken"
        }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListSchedule.fromJson(response.response).scheduleOfTutor??[]);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getOwnSchedule({
    required String accessToken,
    required Function(List<Schedule>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: "",
        headers: {
          "Authorization":"Bearer $accessToken"
        }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListSchedule.fromJson(response.response).scheduleOfTutor??[]);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}
