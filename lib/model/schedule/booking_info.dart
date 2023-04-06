import 'package:json_annotation/json_annotation.dart';

import 'class_review.dart';
import 'schedule_detail.dart';

part 'booking_info.g.dart';

@JsonSerializable()
class BookingInfo {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  String? studentRequest;
  String? tutorReview;
  int? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  String? recordUrl;

  // String? cancelReasonId;
  // String? lessonPlanId;
  // String? cancelNote;
  // String? calendarId;
  bool? isDeleted;
  ScheduleDetail? scheduleDetailInfo;
  ClassReview? classReview;

  BookingInfo({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    this.studentRequest,
    this.tutorReview,
    this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    this.recordUrl,
    // this.cancelReasonId,
    // this.lessonPlanId,
    // this.cancelNote,
    // this.calendarId,
    this.isDeleted,
    this.scheduleDetailInfo,
    this.classReview,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}
