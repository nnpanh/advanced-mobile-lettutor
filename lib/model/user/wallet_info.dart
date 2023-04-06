import 'package:json_annotation/json_annotation.dart';

part 'wallet_info.g.dart';

@JsonSerializable()
class WalletInfo {
  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? bonus;

  WalletInfo({
    this.id,
    this.userId,
    this.amount,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.bonus,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) =>
      _$WalletInfoFromJson(json);
  Map<String, dynamic> toJson() => _$WalletInfoToJson(this);
}
