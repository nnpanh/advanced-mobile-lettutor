import 'package:flutter/cupertino.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale("en", "US");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}
