import 'package:flutter/cupertino.dart';
import 'package:lettutor/data/dto/auth/input_login_by_mail.dart';

import '../data/dto/auth/response_login_by_mail.dart';
import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;

  bool isLoggedIn = false;

  AuthProvider() {
    authRepository = AuthRepository();
  }

}