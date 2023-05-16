import 'package:dio/dio.dart';
import 'package:lettutor/data/services/api_service.dart';

import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import 'base_repository.dart';

class AuthRepository extends BaseRepository {
  static const String prefix = "auth/";

  AuthRepository() : super(prefix);

  Future<void> loginByMail({
    required String email,
    required String password,
    required Function(UserModel, UserToken) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(url: 'login', data: {
      "email": email,
      "password": password,
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserModel.fromJson(response.response['user']);
        final token = UserToken.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> loginByPhone({
    required String phone,
    required String password,
    required Function(UserModel, UserToken) onSuccess,
  }) async {
    final response = await service.post(url: 'phone-login', data: {
      "phone": phone,
      "password": password,
    });

    final user = UserModel.fromJson(response['user']);
    final token = UserToken.fromJson(response['tokens']);
    await onSuccess(user, token);
  }

  Future<void> loginByGoogle({
    required String accessToken,
    required Function(UserModel, UserToken) onSuccess,
  }) async {
    final response = await service.post(url: 'google', data: {
      "access_token": accessToken,
    });

    final user = UserModel.fromJson(response['user']);
    final token = UserToken.fromJson(response['tokens']);
    await onSuccess(user, token);
  }

  Future<void> loginByFacebook({
    required String accessToken,
    required Function(UserModel, UserToken) onSuccess,
  }) async {
    final response = await service.post(url: 'facebook', data: {
      "access_token": accessToken,
    });

    final user = UserModel.fromJson(response['user']);
    final token = UserToken.fromJson(response['tokens']);
    await onSuccess(user, token);
  }

  Future<void> signUpByMail({
    required String email,
    required String password,
    required Function(UserModel, UserToken) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.postFormData(
            url: "register",
        headers: {
          "origin": "https://sandbox.app.lettutor.com",
          "referer":  "https://sandbox.app.lettutor.com/",
        },
            data: {"email": email, "password": password, "source": null})
        as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserModel.fromJson(response.response['user']);
        final token = UserToken.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> signUpByPhone({
    required String phone,
    required String password,
    required Function(UserModel, UserToken) onSuccess,
    required Function() onFail,
  }) async {
    final response = await service.postFormData(
        url: "register",
        data: {"phone": phone, "password": password, "source": null});

    if (!response is DioError) {
      final user = UserModel.fromJson(response['user']);
      final token = UserToken.fromJson(response['tokens']);
      await onSuccess(user, token);
    } else {
      onFail();
    }
  }

  Future<void> refreshToken({
    required String refreshToken,
    required Function(UserModel, UserToken) onSuccess,
  }) async {
    final response = await service.post(
        url: "refresh-token",
        data: {"refreshToken": refreshToken, "timezone": 7})  as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserModel.fromJson(response.response['user']);
        final token = UserToken.fromJson(response.response['tokens']);
        await onSuccess(user, token);
        break;
      default:
        break;
    }
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> changePassword({
    required String password,
    required String newPassword,
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "change-password",
        data: {"password": password, "newPassword": newPassword});

    await onSuccess();
  }
}
