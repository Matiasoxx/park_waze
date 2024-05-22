import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:park_waze/app/data/services/local_storage.dart';
import 'package:park_waze/app/data/services/push_notification.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_admin.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_user.dart';
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
  await LocalStorage().init();

  if (!kIsWeb) {
    await PushNotificationService.initializeApp();
  }

  // Inicializa el LocaleProvider y carga el idioma guardado
  final localeProvider = LocaleProvider();
  await localeProvider.loadLocale();
  final isSignedIn = await LocalStorage().getIsSignedIn();
  final userData = await LocalStorage().getUserData();
  final userRole = await LocalStorage().getRole();

  runApp(MyApp(
    localeProvider: localeProvider,
    isSignedIn: isSignedIn,
    userData: userData,
    userRole: userRole,
    initialRoute: kIsWeb ? Routes.login : Routes.splash, // Ajustar la ruta inicial según la plataforma
  ));
}

class MyApp extends StatelessWidget {
  final LocaleProvider localeProvider;
  final bool isSignedIn;
  final dynamic userData;
  final String? userRole;
  final String initialRoute;

  const MyApp({
    super.key,
    required this.localeProvider,
    required this.isSignedIn,
    this.userData,
    this.userRole,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => localeProvider),
        ChangeNotifierProvider(
          create: (_) => LoginProvider()..checkAuthState(),
        ),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
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
            initialRoute: initialRoute,
            routes: appRoutes,
            onGenerateRoute: (settings) {
              if (isSignedIn && userData != null && userRole != null) {
                if (userRole == 'user') {
                  return MaterialPageRoute(
                    builder: (_) => HomeViewUser(userData: userData),
                  );
                } else if (userRole == 'admin') {
                  return MaterialPageRoute(
                    builder: (_) => HomeViewAdmin(userData: userData),
                  );
                }
              }
              return null; // Dejar que MaterialApp maneje la ruta
            },
          );
        },
      ),
    );
  }
}
