import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/model/tutor/tutor_extracted_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

import '../../model/schedule/schedule.dart';
import '../../model/tutor/favorite_tutor.dart';

part 'response_get_list_schedule.g.dart';

@JsonSerializable()
class ResponseGetListSchedule {
  String? message;
  List<Schedule>? scheduleOfTutor;

  ResponseGetListSchedule({
    this.message,
    this.scheduleOfTutor,
  });

  factory ResponseGetListSchedule.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListScheduleFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListScheduleToJson(this);
}
