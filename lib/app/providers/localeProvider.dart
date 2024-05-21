import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      setLocale(const Locale('en', 'US'));
    } else {
      setLocale(const Locale('es', 'ES'));
    }
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode =
        prefs.getString('language_code') ?? 'en'; // Default to English
    setLocale(Locale(languageCode));
  }
}
