import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/schedule/lesson_status.dart';

part 'class_review.g.dart';

@JsonSerializable()
class ClassReview {
  final String? bookingId;
  final int? lessonStatusId;
  final String? book;
  final String? unit;
  final String? lesson;
  final dynamic page;
  final String? lessonProgress;
  final int? behaviorRating;
  final String? behaviorComment;
  final int? listeningRating;
  final String? listeningComment;
  final int? speakingRating;
  final String? speakingComment;
  final int? vocabularyRating;
  final String? vocabularyComment;
  final String? homeworkComment;
  final String? overallComment;
  final LessonStatus? lessonStatus;

  ClassReview({
    this.bookingId,
    this.lessonStatusId,
    this.book,
    this.unit,
    this.lesson,
    this.page,
    this.lessonProgress,
    this.behaviorRating,
    this.behaviorComment,
    this.listeningRating,
    this.listeningComment,
    this.speakingRating,
    this.speakingComment,
    this.vocabularyRating,
    this.vocabularyComment,
    this.homeworkComment,
    this.overallComment,
    this.lessonStatus,
  });

  factory ClassReview.fromJson(Map<String, dynamic> json) =>
      _$ClassReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ClassReviewToJson(this);
}
