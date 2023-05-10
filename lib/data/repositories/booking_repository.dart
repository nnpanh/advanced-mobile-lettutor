import 'package:lettutor/data/responses/response_get_list_booking_info.dart';
import 'package:lettutor/data/responses/response_get_next_booking_info.dart';
import 'package:lettutor/model/schedule/booking_info.dart';

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
    required Function(List<BookingInfo>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
            "list/student?page=$page&perPage=$perPage&dateTimeLte=$now&orderBy=meeting&sortBy=desc",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListBooking.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
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
    required Function(List<BookingInfo>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url:
            "list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=desc",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListBooking.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getUpcomingLessonAtHomePage({
    required String accessToken,
    required int now,
    required Function(List<BookingInfo>) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "next?dateTime=$now",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        onSuccess(
            ResponseGetNextBookingInfo.fromJson(response.response).data ?? []);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> bookLesson({
    required String accessToken,
    required String notes,
    required List<String> scheduleDetailIds,
    required Function(String) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.post(
        url: "",
        data: {"note": notes, "scheduleDetailIds": scheduleDetailIds},
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
