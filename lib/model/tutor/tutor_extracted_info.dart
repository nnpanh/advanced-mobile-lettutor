import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/tutor/tutor_info.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

part 'tutor_extracted_info.g.dart';

@JsonSerializable()
class TutorExtractedInfo {
  String? level;
  String? email;
  String? google;
  String? facebook;
  String? apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  bool? isPhoneActivated;
  String? requireNote;
  int? timezone;
  String? phoneAuth;
  bool? isPhoneAuthActivated;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  String? caredByStaffId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? studentGroupId;
  TutorInfo? tutorInfo;

  TutorExtractedInfo({
    this.level,
    this.email,
    this.google,
    this.facebook,
    this.apple,
    this.avatar,
    this.name,
    this.country,
    this.phone,
    this.language,
    this.birthday,
    this.requestPassword,
    this.isActivated,
    this.isPhoneActivated,
    this.requireNote,
    this.timezone,
    this.phoneAuth,
    this.isPhoneAuthActivated,
    this.studySchedule,
    this.canSendMessage,
    this.isPublicRecord,
    this.caredByStaffId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.studentGroupId,
    this.tutorInfo
  });
  factory TutorExtractedInfo.fromJson(Map<String, dynamic> json) =>
      _$TutorExtractedInfoFromJson(json);
  Map<String, dynamic> toJson() => _$TutorExtractedInfoToJson(this);
}
