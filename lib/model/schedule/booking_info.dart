import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';

import 'class_review.dart';
import 'schedule_detail.dart';

part 'booking_info.g.dart';

//get-booked-course
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
  bool? isDeleted;
  ScheduleDetail? scheduleDetailInfo;
  ClassReview? classReview;
  //new
  String? cancelReasonId;
  String? lessonPlanId;
  String? cancelNote;
  String? calendarId;
  bool? showRecordUrl;
  List<String>? studentMaterials;
  List<TutorFeedback>? feedbacks;

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
    this.isDeleted,
    this.scheduleDetailInfo,
    this.classReview,
    this.cancelReasonId,
    this.lessonPlanId,
    this.cancelNote,
    this.calendarId,
    this.showRecordUrl,
    this.studentMaterials,
    this.feedbacks,
  });

  factory BookingInfo.fromJson(Map<String, dynamic> json) =>
      _$BookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BookingInfoToJson(this);
}
