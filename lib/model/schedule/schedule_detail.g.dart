// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduleDetail _$ScheduleDetailFromJson(Map<String, dynamic> json) =>
    ScheduleDetail(
      startPeriodTimestamp: json['startPeriodTimestamp'] as int?,
      endPeriodTimestamp: json['endPeriodTimestamp'] as int?,
      id: json['id'] as String?,
      scheduleId: json['scheduleId'] as String?,
      startPeriod: json['startPeriod'] as String?,
      endPeriod: json['endPeriod'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      bookingInfo: (json['bookingInfo'] as List<dynamic>?)
          ?.map((e) => BookingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      isBooked: json['isBooked'] as bool?,
      scheduleInfo: json['scheduleInfo'] == null
          ? null
          : Schedule.fromJson(json['scheduleInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleDetailToJson(ScheduleDetail instance) =>
    <String, dynamic>{
      'startPeriodTimestamp': instance.startPeriodTimestamp,
      'endPeriodTimestamp': instance.endPeriodTimestamp,
      'id': instance.id,
      'scheduleId': instance.scheduleId,
      'startPeriod': instance.startPeriod,
      'endPeriod': instance.endPeriod,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'bookingInfo': instance.bookingInfo,
      'isBooked': instance.isBooked,
      'scheduleInfo': instance.scheduleInfo,
    };
