import 'package:json_annotation/json_annotation.dart';

part 'test_preparation.g.dart';

@JsonSerializable()
class TestPreparation {
  int? id;
  String? key;
  String? name;

  TestPreparation({this.id, this.key, this.name});
  factory TestPreparation.fromJson(Map<String, dynamic> json) =>
      _$TestPreparationFromJson(json);
  Map<String, dynamic> toJson() => _$TestPreparationToJson(this);
}
