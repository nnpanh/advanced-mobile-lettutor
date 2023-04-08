// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_preparation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestPreparation _$TestPreparationFromJson(Map<String, dynamic> json) =>
    TestPreparation(
      id: json['id'] as int?,
      key: json['key'] as String?,
      name: json['name'] as String?,
    )
      ..createdAt = json['createdAt'] as String?
      ..updatedAt = json['updatedAt'] as String?;

Map<String, dynamic> _$TestPreparationToJson(TestPreparation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
