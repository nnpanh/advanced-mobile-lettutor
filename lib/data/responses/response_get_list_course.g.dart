// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetListCourse _$ResponseGetListCourseFromJson(
        Map<String, dynamic> json) =>
    ResponseGetListCourse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CoursePagination.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseGetListCourseToJson(
        ResponseGetListCourse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
    };

CoursePagination _$CoursePaginationFromJson(Map<String, dynamic> json) =>
    CoursePagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CoursePaginationToJson(CoursePagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
