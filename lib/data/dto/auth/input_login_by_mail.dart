
import 'package:json_annotation/json_annotation.dart';
part 'input_login_by_mail.g.dart';

@JsonSerializable()
class InputLoginByMail {
  String email;
  String password;

  InputLoginByMail({required this.email, required this.password});

  factory InputLoginByMail.fromJson(Map<String, dynamic> json) => _$InputLoginByMailFromJson(json);
  Map<String, dynamic> toJson() => _$InputLoginByMailToJson(this);
}