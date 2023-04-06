import 'package:flutter/cupertino.dart';

import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;

  bool isLoggedIn = false;

  AuthProvider() {
    authRepository = AuthRepository();
  }
}
