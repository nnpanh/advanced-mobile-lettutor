// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_next_booking_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetNextBookingInfo _$ResponseGetNextBookingInfoFromJson(
        Map<String, dynamic> json) =>
    ResponseGetNextBookingInfo(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetNextBookingInfoToJson(
        ResponseGetNextBookingInfo instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };
