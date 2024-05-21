import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_page.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_admin.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_user.dart';
import 'package:park_waze/app/presentacion/pages/login/login_view.dart';
import 'package:park_waze/app/presentacion/pages/reset_pass/reset_passw_page.dart';
import 'package:park_waze/app/presentacion/pages/sign_in/vistas/sign_in_view.dart';
import 'package:park_waze/app/presentacion/pages/splash/vistas/splash_view.dart';
import 'package:park_waze/app/presentacion/routes/routes.dart';

Map<String, WidgetBuilder> get appRoutes {
  return {
    Routes.splash: (context) => const SplashScreen(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      if (args == null) {
        return const LoginView(); // O alguna otra vista de error
      }
      return HomeView(
        userData: args['userData'],
        role: args['role'],
      );
    },
    Routes.homeViewUser: (context) => const HomeViewUser(
          userData: null,
        ),
    Routes.homeViewAdmin: (context) => const HomeViewAdmin(
          userData: null,
        ),
    Routes.login: (context) => const LoginView(),
    Routes.homeh: (context) => const HomePageWidget(),
    Routes.reset_password: (context) => const ResetPasswordPage(),
    //Aqui se añade otra ruta como este formato
  };
}
