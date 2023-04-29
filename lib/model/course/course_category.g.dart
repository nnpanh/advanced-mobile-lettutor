// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCategory _$CourseCategoryFromJson(Map<String, dynamic> json) =>
    CourseCategory(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      key: json['key'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CourseCategoryToJson(CourseCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'key': instance.key,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
