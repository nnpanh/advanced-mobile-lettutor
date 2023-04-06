import 'package:json_annotation/json_annotation.dart';

import 'first_info.dart';

part 'tutor_feedback.g.dart';

@JsonSerializable()
class TutorFeedback {
  String? id;
  String? bookingId;
  String? firstId;
  String? secondId;
  int? rating;
  String? content;
  String? createdAt;
  String? updatedAt;
  FirstInfo? firstInfo;

  TutorFeedback({
    this.id,
    this.bookingId,
    this.firstId,
    this.secondId,
    this.rating,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.firstInfo,
  });

  factory TutorFeedback.fromJson(Map<String, dynamic> json) =>
      _$TutorFeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$TutorFeedbackToJson(this);
}
