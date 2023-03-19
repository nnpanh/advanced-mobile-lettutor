
import 'package:flutter/cupertino.dart';
import 'package:lettutor/data/dto/auth/input_login_by_mail.dart';
import 'package:lettutor/data/dto/auth/response_login_by_mail.dart';

import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  // static const String prefix = "auth/";
  static const String prefix = "";

  AuthRepository(String apiBaseUrl) : super(apiBaseUrl, prefix);

  Future<ResponseLoginByMail?> loginByMail({required InputLoginByMail input}) async {
    final response = await provider.post(
      url: "",
      // url: "login",
      // headers: {
      //   "Access-Token": "123"
      // },
      data: input.toJson(),
    );

    ResponseLoginByMail test = ResponseLoginByMail.fromJson(response);

    return test;
  }
}
