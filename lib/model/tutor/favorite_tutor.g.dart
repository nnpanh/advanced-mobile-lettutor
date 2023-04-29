// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteTutor _$FavoriteTutorFromJson(Map<String, dynamic> json) =>
    FavoriteTutor(
      id: json['id'] as String?,
      firstId: json['firstId'] as String?,
      secondId: json['secondId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      secondInfo: json['secondInfo'] == null
          ? null
          : TutorExtractedInfo.fromJson(
              json['secondInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FavoriteTutorToJson(FavoriteTutor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstId': instance.firstId,
      'secondId': instance.secondId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'secondInfo': instance.secondInfo,
    };
