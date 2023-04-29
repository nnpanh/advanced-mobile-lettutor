import 'package:lettutor/model/user/user_model.dart';

import '../services/api_service.dart';
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

  Future<void> updateUserInfo({
    required String accessToken,
    required UserModel input,
    required Function(UserModel) onSuccess,
    required Function(String) onFail,
  }) async {
    var learnTopics = [];
    input.learnTopics?.forEach((element) {
      learnTopics.add(element.id);
    });
    var testPreparations = [];
    input.testPreparations?.forEach((element) {
      testPreparations.add(element.id);
    });
    final response = await service.put(url: 'info',
        headers: {
          "Authorization":"Bearer $accessToken"
        },
        data: {
      "name": input.name,
      "country": input.country,
      "phone": input.phone,
      "birthday": input.birthday,
      "level": input.level,
      "learnTopics": learnTopics,
      "testPreparations": testPreparations
    }) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        final user = UserModel.fromJson(response.response['user']);
        await onSuccess(user);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
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

  Future<void> resetPassword({
    required String email,
    required Function(String) showMessage,
  }) async {
    var response =
        await service.post(url: "forgotPassword", headers: {
          "origin": "https://sandbox.api.lettutor.com",
          "referer":  "https://sandbox.api.lettutor.com",
        }, data: {"email": email}) as BoundResource;
    switch (response.statusCode) {
      case 200:
      case 201:
        showMessage(response.response['message']);
        break;
      default:
        showMessage(response.errorMsg.toString());
        break;
    }
  }
}
