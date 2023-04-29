import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/course/course_model.dart';
import 'package:lettutor/model/schedule/booking_info.dart';
import 'package:lettutor/model/tutor/tutor_extracted_info.dart';
import 'package:lettutor/model/tutor/tutor_feedback.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

import '../../model/tutor/favorite_tutor.dart';

part 'response_get_list_booking_info.g.dart';

@JsonSerializable()
class ResponseGetListBooking {
  String? message;
  BookingPagination? data;

  ResponseGetListBooking({
    this.message,
    this.data,
  });

  factory ResponseGetListBooking.fromJson(Map<String, dynamic> json) =>
      _$ResponseGetListBookingFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseGetListBookingToJson(this);
}


@JsonSerializable()
class BookingPagination {
  int? count;
  List<BookingInfo>? rows;

  BookingPagination({
    this.count,
    this.rows,
  });

  factory BookingPagination.fromJson(Map<String, dynamic> json) =>
      _$BookingPaginationFromJson(json);
  Map<String, dynamic> toJson() => _$BookingPaginationToJson(this);
}

