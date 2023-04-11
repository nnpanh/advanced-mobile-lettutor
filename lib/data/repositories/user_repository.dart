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

  Future<void> resetPassword({
    required String email,
    required Function(String) showMessage,
  }) async {
    var response =
        await service.post(url: "forgotPassword", data: {"email": email}) as BoundResource;
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
