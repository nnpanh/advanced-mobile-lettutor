import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:lettutor/data/responses/response_get_list_booking_info.dart';
import 'package:lettutor/data/responses/response_get_list_course.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/schedule/schedule.dart';

import '../../model/course/course_model.dart';
import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import '../responses/response_get_list_schedule.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class BookingRepository extends BaseRepository {
  static const String prefix = "booking/";

  BookingRepository() : super(prefix);

  Future<void> getLearningHistory({
    required String accessToken,
    required String now,
    required int page,
    required int perPage,
    required Function(List<BookingInfo>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "list/student?page=$page&perPage=$perPage&dateTimeLte=$now&orderBy=meeting&sortBy=desc",
        headers: {
          "Authorization":"Bearer $accessToken"
        }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListBooking.fromJson(response.response).data?.rows??[]);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getIncomingLessons({
  required String accessToken,
  required String now,
  required int page,
  required int perPage,
  required Function(List<BookingInfo>) onSuccess,
  required Function(String) onFail,
  }) async {
  final response = await service.get(
  url: "list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=desc",
  headers: {
  "Authorization":"Bearer $accessToken"
  }) as BoundResource;

  switch (response.statusCode) {
  case 200:
  case 201:
  onSuccess(ResponseGetListBooking.fromJson(response.response).data?.rows??[]);
  break;
  default:
  onFail(response.errorMsg.toString());
  break;
  }
  }
  //Bôk a class
//Cancel a class
//Change studen request
}
