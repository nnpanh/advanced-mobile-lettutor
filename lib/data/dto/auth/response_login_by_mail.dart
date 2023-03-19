import 'package:json_annotation/json_annotation.dart';
part 'response_login_by_mail.g.dart';

@JsonSerializable()
class ResponseLoginByMail {
  bool isSuccess;

  ResponseLoginByMail({required this.isSuccess});

  factory ResponseLoginByMail.fromJson(Map<String, dynamic> json) => _$ResponseLoginByMailFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseLoginByMailToJson(this);
}