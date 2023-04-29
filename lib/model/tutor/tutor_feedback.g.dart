// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorFeedback _$TutorFeedbackFromJson(Map<String, dynamic> json) =>
    TutorFeedback(
      id: json['id'] as String?,
      bookingId: json['bookingId'] as String?,
      firstId: json['firstId'] as String?,
      secondId: json['secondId'] as String?,
      rating: json['rating'] as int?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      firstInfo: json['firstInfo'] == null
          ? null
          : TutorExtractedInfo.fromJson(
              json['firstInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TutorFeedbackToJson(TutorFeedback instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bookingId': instance.bookingId,
      'firstId': instance.firstId,
      'secondId': instance.secondId,
      'rating': instance.rating,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'firstInfo': instance.firstInfo,
    };
