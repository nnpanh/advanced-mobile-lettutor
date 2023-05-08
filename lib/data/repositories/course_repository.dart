import 'package:lettutor/data/responses/response_get_list_course.dart';

import '../../model/course/course_model.dart';
import '../services/api_service.dart';
import 'base_repository.dart';

class CourseRepository extends BaseRepository {
  static const String prefix = "";

  CourseRepository() : super(prefix);

  Future<void> getCourseListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String search,
    required Function(List<CourseModel>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "course?page=$page&size=$size&q=$search",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListCourse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }

  Future<void> getEbookListWithPagination({
    required String accessToken,
    required int size,
    required int page,
    required String search,
    required Function(List<CourseModel>, int) onSuccess,
    required Function(String) onFail,
  }) async {
    final response = await service.get(
        url: "e-book?page=$page&size=$size&q=$search",
        headers: {"Authorization": "Bearer $accessToken"}) as BoundResource;

    switch (response.statusCode) {
      case 200:
      case 201:
        var result = ResponseGetListCourse.fromJson(response.response).data;
        onSuccess(result?.rows ?? [], result?.count ?? 0);
        break;
      default:
        onFail(response.errorMsg.toString());
        break;
    }
  }
}
