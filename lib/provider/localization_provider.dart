import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocalizationProvider with ChangeNotifier {
  Locale locale = Locale(Intl.getCurrentLocale());

  void changeLang(String lang) {
    print(lang);
    locale = Locale(lang);
    notifyListeners();
  }
}
