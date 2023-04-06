import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/user/user_model.dart';

part 'tutor_info.g.dart';

@JsonSerializable()
class TutorInfo {
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  bool? isNative;
  UserModel? user;
  bool? isFavorite;
  num? avgRating;
  int? totalFeedback;

  TutorInfo({
    this.video,
    this.bio,
    this.education,
    this.experience,
    this.profession,
    this.accent,
    this.targetStudent,
    this.interests,
    this.languages,
    this.specialties,
    this.rating,
    this.isNative,
    this.user,
    this.isFavorite,
    this.avgRating,
    this.totalFeedback,
  });

  factory TutorInfo.fromJson(Map<String, dynamic> json) =>
      _$TutorInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TutorInfoToJson(this);
}
