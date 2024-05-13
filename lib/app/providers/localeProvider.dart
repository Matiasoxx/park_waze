import 'package:flutter/material.dart';

class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('es', 'ES');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners(); // Asegúrate de que esto se llama correctamente
    }
  }

  void toggleLocale() {
    if (_locale.languageCode == 'es') {
      setLocale(const Locale('es', 'ES'));
    } else {
      setLocale(const Locale('en', 'US'));
    }
  }
}
