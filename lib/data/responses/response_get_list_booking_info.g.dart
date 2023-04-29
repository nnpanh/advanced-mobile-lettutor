// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_booking_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetListBooking _$ResponseGetListBookingFromJson(
        Map<String, dynamic> json) =>
    ResponseGetListBooking(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BookingPagination.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetListBookingToJson(
        ResponseGetListBooking instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

BookingPagination _$BookingPaginationFromJson(Map<String, dynamic> json) =>
    BookingPagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingPaginationToJson(BookingPagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
