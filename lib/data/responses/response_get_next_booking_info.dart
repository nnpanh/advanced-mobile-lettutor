import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/tutor/tutor_extracted_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

import '../../model/tutor/favorite_tutor.dart';

part 'response_get_next_booking_info.g.dart';

@JsonSerializable()
class ResponseGetNextBookingInfo {
  String? message;
  List<BookingInfo>? data;

  ResponseGetNextBookingInfo({
    this.message,
    this.data,
  });

  factory ResponseGetNextBookingInfo.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetNextBookingInfoFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetNextBookingInfoToJson(this);
}



