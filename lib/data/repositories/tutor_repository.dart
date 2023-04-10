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

  /*
  {{base_url}}tutor/more?perPage=9&page=1
   */
  //TODO: RESPONSE UNKNOWN
  Future<void> getListTutor({
    required Function() onSuccess,
  }) async {
    final response = await service.get(
      url: "more?perPage=9&page=1",
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> writeReviewAfterClass({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
      url: "feedbackTutor",
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> getTutorById({
    required Function() onSuccess,
  }) async {
    final response = await service.get(
      url: "tutor/:tutorId",
    );

    await onSuccess();
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
