// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetListSchedule _$ResponseGetListScheduleFromJson(
        Map<String, dynamic> json) =>
    ResponseGetListSchedule(
      message: json['message'] as String?,
      scheduleOfTutor: (json['scheduleOfTutor'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetListScheduleToJson(
        ResponseGetListSchedule instance) =>
    <String, dynamic>{
      'message': instance.message,
      'scheduleOfTutor': instance.scheduleOfTutor,
    };
