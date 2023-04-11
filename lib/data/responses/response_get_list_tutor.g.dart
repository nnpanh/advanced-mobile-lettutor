// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_get_list_tutor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseGetListTutor _$ResponseGetListTutorFromJson(
        Map<String, dynamic> json) =>
    ResponseGetListTutor(
      tutors: json['tutors'] == null
          ? null
          : TutorPagination.fromJson(json['tutors'] as Map<String, dynamic>),
      favoriteTutor: (json['favoriteTutor'] as List<dynamic>?)
          ?.map((e) => FavoriteTutor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResponseGetListTutorToJson(
        ResponseGetListTutor instance) =>
    <String, dynamic>{
      'tutors': instance.tutors,
      'favoriteTutor': instance.favoriteTutor,
    };

TutorPagination _$TutorPaginationFromJson(Map<String, dynamic> json) =>
    TutorPagination(
      count: json['count'] as int?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => TutorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TutorPaginationToJson(TutorPagination instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };
