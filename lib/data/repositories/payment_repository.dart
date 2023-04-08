import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import '../../model/user/user_model.dart';
import '../../model/user/user_token.dart';
import 'base_repository.dart';

class PaymentRepository extends BaseRepository {
  static const String prefix = "payment/";

  PaymentRepository() : super(prefix);

  //TODO: RESPONSE UNKNOWN
  Future<void> getPaymentHistory({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "history",
    );

    await onSuccess();
  }

  //TODO: RESPONSE UNKNOWN
  Future<void> getPaymentStatistic({
    required Function() onSuccess,
  }) async {
    final response = await service.post(
        url: "statistics",
    );

    await onSuccess();
  }
}
