// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tutor_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TutorInfo _$TutorInfoFromJson(Map<String, dynamic> json) => TutorInfo(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      video: json['video'] as String?,
      bio: json['bio'] as String?,
      education: json['education'] as String?,
      experience: json['experience'] as String?,
      profession: json['profession'] as String?,
      accent: json['accent'] as String?,
      targetStudent: json['targetStudent'] as String?,
      interests: json['interests'] as String?,
      languages: json['languages'] as String?,
      specialties: json['specialties'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      isNative: json['isNative'] as bool?,
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      isFavorite: json['isFavorite'] as bool?,
      avgRating: json['avgRating'] as num?,
      totalFeedback: json['totalFeedback'] as int?,
    );

Map<String, dynamic> _$TutorInfoToJson(TutorInfo instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'video': instance.video,
      'bio': instance.bio,
      'education': instance.education,
      'experience': instance.experience,
      'profession': instance.profession,
      'accent': instance.accent,
      'targetStudent': instance.targetStudent,
      'interests': instance.interests,
      'languages': instance.languages,
      'specialties': instance.specialties,
      'rating': instance.rating,
      'isNative': instance.isNative,
      'user': instance.user,
      'isFavorite': instance.isFavorite,
      'avgRating': instance.avgRating,
      'totalFeedback': instance.totalFeedback,
    };
