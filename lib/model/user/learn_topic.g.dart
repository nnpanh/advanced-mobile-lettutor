// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnTopic _$LearnTopicFromJson(Map<String, dynamic> json) => LearnTopic(
      id: json['id'] as int?,
      key: json['key'] as String?,
      name: json['name'] as String?,
    )
      ..createdAt = json['createdAt'] as String?
      ..updatedAt = json['updatedAt'] as String?;

Map<String, dynamic> _$LearnTopicToJson(LearnTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
