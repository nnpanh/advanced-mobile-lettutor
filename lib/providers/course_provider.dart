import 'package:flutter/cupertino.dart';

class CourseProvider extends ChangeNotifier {
  String _searchKeys = "";
  String get searchKeys => _searchKeys;

  bool reloadFlag = false;

  void setReloadFlag() {
    reloadFlag = false;
  }

  void setKeys(String keys) {
    _searchKeys = keys;
    reloadFlag = true;
    notifyListeners();
  }
}
