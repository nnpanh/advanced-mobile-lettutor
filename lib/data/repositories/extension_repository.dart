import '../services/api_service.dart';
import 'base_repository.dart';

class ExtensionRepository extends BaseRepository {
  static const String prefix = "";

  ExtensionRepository() : super(prefix);

  Future<void> postReportATutor({
    required String accessToken,
    required String reason,
    required String tutorId,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: "report",
        data: {"tutorId": tutorId, "content": reason},
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(response.response['message']);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}
