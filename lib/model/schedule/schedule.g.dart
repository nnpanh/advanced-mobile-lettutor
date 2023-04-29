// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Schedule _$ScheduleFromJson(Map<String, dynamic> json) => Schedule(
      id: json['id'] as String?,
      date: json['date'] as String?,
      tutorId: json['tutorId'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      startTimestamp: json['startTimestamp'] as int?,
      endTimestamp: json['endTimestamp'] as int?,
      createdAt: json['createdAt'] as String?,
      isBooked: json['isBooked'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      scheduleDetails: (json['scheduleDetails'] as List<dynamic>?)
          ?.map((e) => ScheduleDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      tutorInfo: json['tutorInfo'] == null
          ? null
          : TutorModel.fromJson(json['tutorInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ScheduleToJson(Schedule instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'tutorId': instance.tutorId,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'startTimestamp': instance.startTimestamp,
      'endTimestamp': instance.endTimestamp,
      'createdAt': instance.createdAt,
      'isBooked': instance.isBooked,
      'isDeleted': instance.isDeleted,
      'scheduleDetails': instance.scheduleDetails,
      'tutorInfo': instance.tutorInfo,
    };
