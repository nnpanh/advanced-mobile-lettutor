// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingInfo _$BookingInfoFromJson(Map<String, dynamic> json) => BookingInfo(
      createdAtTimeStamp: json['createdAtTimeStamp'] as int?,
      updatedAtTimeStamp: json['updatedAtTimeStamp'] as int?,
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      scheduleDetailId: json['scheduleDetailId'] as String?,
      tutorMeetingLink: json['tutorMeetingLink'] as String?,
      studentMeetingLink: json['studentMeetingLink'] as String?,
      studentRequest: json['studentRequest'] as String?,
      tutorReview: json['tutorReview'] as String?,
      scoreByTutor: json['scoreByTutor'] as int?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      recordUrl: json['recordUrl'] as String?,
      isDeleted: json['isDeleted'] as bool?,
      scheduleDetailInfo: json['scheduleDetailInfo'] == null
          ? null
          : ScheduleDetail.fromJson(
              json['scheduleDetailInfo'] as Map<String, dynamic>),
      classReview: json['classReview'] == null
          ? null
          : ClassReview.fromJson(json['classReview'] as Map<String, dynamic>),
      cancelReasonId: json['cancelReasonId'] as String?,
      lessonPlanId: json['lessonPlanId'] as String?,
      cancelNote: json['cancelNote'] as String?,
      calendarId: json['calendarId'] as String?,
      showRecordUrl: json['showRecordUrl'] as bool?,
      feedbacks: (json['feedbacks'] as List<dynamic>?)
          ?.map((e) => TutorFeedback.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingInfoToJson(BookingInfo instance) =>
    <String, dynamic>{
      'createdAtTimeStamp': instance.createdAtTimeStamp,
      'updatedAtTimeStamp': instance.updatedAtTimeStamp,
      'id': instance.id,
      'userId': instance.userId,
      'scheduleDetailId': instance.scheduleDetailId,
      'tutorMeetingLink': instance.tutorMeetingLink,
      'studentMeetingLink': instance.studentMeetingLink,
      'studentRequest': instance.studentRequest,
      'tutorReview': instance.tutorReview,
      'scoreByTutor': instance.scoreByTutor,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'recordUrl': instance.recordUrl,
      'isDeleted': instance.isDeleted,
      'scheduleDetailInfo': instance.scheduleDetailInfo,
      'classReview': instance.classReview,
      'cancelReasonId': instance.cancelReasonId,
      'lessonPlanId': instance.lessonPlanId,
      'cancelNote': instance.cancelNote,
      'calendarId': instance.calendarId,
      'showRecordUrl': instance.showRecordUrl,
      'feedbacks': instance.feedbacks,
    };
