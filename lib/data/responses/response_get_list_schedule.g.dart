// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetListSchedule _$ResponseGetListScheduleFromJson(
        Map<String, dynamic> json) =>
    ResponseGetListSchedule(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : SchedulePagination.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetListScheduleToJson(
        ResponseGetListSchedule instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

SchedulePagination _$SchedulePaginationFromJson(Map<String, dynamic> json) =>
    SchedulePagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SchedulePaginationToJson(SchedulePagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
