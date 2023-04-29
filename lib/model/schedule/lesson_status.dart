import 'package:json_annotation/json_annotation.dart';

part 'lesson_status.g.dart';

@JsonSerializable()
class LessonStatus {
  final int? id;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LessonStatus({
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory LessonStatus.fromJson(Map<String, dynamic> json) =>
      _$LessonStatusFromJson(json);
  Map<String, dynamic> toJson() => _$LessonStatusToJson(this);
}
