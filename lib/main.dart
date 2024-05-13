import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:park_waze/app/data/services/local_storage.dart';
import 'package:park_waze/app/data/services/push_notification.dart';
import 'package:park_waze/app/presentacion/routes/app_routes.dart';
import 'package:park_waze/app/presentacion/routes/routes.dart';
import 'package:park_waze/app/providers/localeProvider.dart';
import 'package:park_waze/app/providers/login_provider.dart';
import 'package:park_waze/app/providers/signin_provider.dart';
import 'package:park_waze/firebase_options.dart';
import 'package:park_waze/generated/l10n.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Intl.defaultLocale = 'es_ES';
  await initializeDateFormatting('es_ES', null);
  await PushNotificationService.initializeApp();
  await LocalStorage().init();
  final isLogged = LocalStorage().getIsLoggedIn();

  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(
            create: (_) => LoginProvider()..checkAuthState()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
      ],
      child:
          Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
        print("Current locale: ${localeProvider.locale.toString()}");
        return MaterialApp(
          locale: localeProvider.locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.homeh,
          routes: appRoutes,
        );
      }),
    );
  }
}
