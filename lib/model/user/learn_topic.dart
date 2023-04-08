import 'package:json_annotation/json_annotation.dart';

part 'learn_topic.g.dart';

@JsonSerializable()
class LearnTopic {
  int? id;
  String? key;
  String? name;
  String? createdAt;
  String? updatedAt;

  LearnTopic({this.id, this.key, this.name});
  factory LearnTopic.fromJson(Map<String, dynamic> json) =>
      _$LearnTopicFromJson(json);
  Map<String, dynamic> toJson() => _$LearnTopicToJson(this);
}
