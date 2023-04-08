import 'package:json_annotation/json_annotation.dart';

import '../tutor/tutor_model.dart';
import 'schedule_detail.dart';

part 'schedule.g.dart';

@JsonSerializable()
class Schedule {
  String? id;
  String? date;
  String? tutorId;
  String? startTime;
  String? endTime;
  int? startTimestamp;
  int? endTimestamp;
  String? createdAt;
  bool? isBooked;
  bool? isDeleted;
  List<ScheduleDetail>? scheduleDetails;
  TutorModel? tutorInfo;

  Schedule({
    this.id,
    this.date,
    this.tutorId,
    this.startTime,
    this.endTime,
    this.startTimestamp,
    this.endTimestamp,
    this.createdAt,
    this.isBooked,
    this.isDeleted,
    this.scheduleDetails,
    this.tutorInfo,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduleToJson(this);
}
