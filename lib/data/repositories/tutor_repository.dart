import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lettutor/data/responses/response_get_list_tutor.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';

import '../services/api_service.dart';
import 'base_repository.dart';

class TutorRepository extends BaseRepository {
  static const String prefix = "tutor/";

  TutorRepository() : super(prefix);

  //TODO: RESPONSE UNKNOWN
  Future<void> becomeTutor({
    required Function() onSuccess,
  }) async {
    final response = await service.postFormData(
      url: "register",
      data: {},
    );

    await onSuccess();
  }

  Future<void> getListTutor({
    required String accessToken,
    required int perPage,
    required int page,
    required Function(ResponseGetListTutor) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
      url: "more?perPage=$perPage&page=$page",
      headers: {
        "Authorization":"Bearer $accessToken"
      }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(ResponseGetListTutor.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> writeReviewAfterClass({
    required Function() onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
      url: "feedbackTutor",

    );

    await onSuccess();
  }

  Future<void> getTutorById({
    required String accessToken,
    required String tutorId,
    required Function(TutorInfo) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
      url: "$tutorId",
        headers: {
          "Authorization":"Bearer $accessToken"
      }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(TutorInfo.fromJson(response.response));
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> searchTutor({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
      url: "search",
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> addTutorToFavorite({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
      url: "manageFavoriteTutor",
    );

    await onSuccess();
  }
}
