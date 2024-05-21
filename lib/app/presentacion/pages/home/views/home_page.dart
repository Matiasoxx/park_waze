import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:park_waze/app/providers/localeProvider.dart';
import 'package:park_waze/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    _loadLocale();
  }

  void _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language_code') ??
        'en'; // Default to 'en' if nothing is saved
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(Locale(languageCode));
  }

  void _changeLanguage(String newLanguageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLanguageCode);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(Locale(newLanguageCode));
    setState(() {}); // This will trigger the UI to rebuild with the new locale
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    String currentLanguageCode = localeProvider.locale.languageCode;

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 170),
                Text(
                  S.of(context).tWelcome,
                  style: GoogleFonts.urbanist(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    S.of(context).languagePrompt,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                DropdownButton<String>(
                  value:
                      currentLanguageCode, // Asegúrate de que este valor inicial está en la lista de valores de los items.
                  onChanged: (String? newValue) {
                    if (newValue != null && newValue != currentLanguageCode) {
                      _changeLanguage(newValue);
                    }
                  },
                  items: <String>['en', 'es']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value == 'en'
                            ? S.of(context).english
                            : S.of(context).spanish,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Text(
                    S.of(context).accountPrompt,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: GoogleFonts.plusJakartaSans(
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(S.of(context).bLogin),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sign-in');
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Theme.of(context).primaryColor,
                          textStyle: GoogleFonts.plusJakartaSans(
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(S.of(context).bRegister),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
