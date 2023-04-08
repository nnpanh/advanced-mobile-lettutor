import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import 'base_repository.dart';

class UserRepository extends BaseRepository {
  static const String prefix = "user/";

  UserRepository() : super(prefix);

  //TODO: RESPONSE UNKNOWN
  Future<void> getUser({
    required Function() onSuccess,
  }) async {
    final response = await service.get(
        url: "info",
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> postUser({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "info",
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> getReferrals({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "referrals",
    );

    await onSuccess();
  }
}
