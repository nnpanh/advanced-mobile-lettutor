import 'package:json_annotation/json_annotation.dart';
import 'package:lettutor/model/tutor/tutor_model.dart';

import 'tutor_extracted_info.dart';

part 'favorite_tutor.g.dart';

@JsonSerializable()
class FavoriteTutor {
  String? id;
  String? firstId;
  String? secondId; // = userId ??
  String? createdAt;
  String? updatedAt;
  TutorExtractedInfo? secondInfo;

  FavoriteTutor({
    this.id,
    this.firstId,
    this.secondId,
    this.createdAt,
    this.updatedAt,
    this.secondInfo,
  });

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) =>
      _$FavoriteTutorFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteTutorToJson(this);
}
