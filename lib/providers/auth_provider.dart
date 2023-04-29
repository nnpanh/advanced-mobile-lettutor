import 'package:flutter/cupertino.dart';
import 'package:lettutor/model/user/user_model.dart';
import 'package:lettutor/model/user/user_token.dart';

import '../data/repositories/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  late AuthRepository authRepository;

  UserModel? currentUser;
  UserToken? token;

  AuthProvider() {
    authRepository = AuthRepository();
  }

  void saveLoginInfo(UserModel currentUser, UserToken? token) {
    this.token = token;
    this.currentUser = currentUser;
    notifyListeners();
  }

  void clearUserInfo() {
    token = null;
    currentUser = null;
    notifyListeners();
  }
}
