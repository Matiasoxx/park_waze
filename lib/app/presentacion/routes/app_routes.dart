import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_page.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_admin.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_user.dart';
import 'package:park_waze/app/presentacion/pages/login/login_view.dart';
import 'package:park_waze/app/presentacion/pages/sign_in/vistas/sign_in_view.dart';
import 'package:park_waze/app/presentacion/pages/splash/vistas/splash_view.dart';
import 'package:park_waze/app/presentacion/routes/routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.signIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(
          userData: null,
          role: '',
        ),
    Routes.homeViewUser: (context) => const HomeViewUser(
          userData: null,
        ),
    Routes.homeViewaAdmin: (context) => const HomeViewAdmin(
          userData: null,
        ),
    Routes.login: (context) => const LoginView(),
    Routes.homeh: (context) => const HomePageWidget(),
    //Aqui se añade otra ruta como este formato
  };
}
