import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import 'base_repository.dart';

class VerifyRepository extends BaseRepository {
  // static const String prefix = "auth/";
  static const String prefix = "verify/";

  VerifyRepository() : super(prefix);

  //TODO: RESPONSE UNKNOWN
  Future<void> resendOTP({
    required String phone,
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "phone-auth-verify/create",
        data: {
          "phone": phone,
        }
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> activeOTP({
    required String phone,
    required String otp,
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "phone-auth-verify/activate",
        data: {
          "phone": phone,
          "otp": otp,
        }
    );

    await onSuccess();
  }
}
