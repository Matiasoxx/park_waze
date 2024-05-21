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
import 'package:park_waze/app/presentacion/vista_admin/estadisticas.dart';
import 'package:park_waze/app/presentacion/vista_admin/permanencia_view.dart';
import 'package:park_waze/app/presentacion/vista_admin/preferencias_view.dart';
import 'package:park_waze/app/presentacion/vista_admin/profileAdmin.dart';
import 'package:park_waze/app/presentacion/vista_admin/tiempo_estacionamiento_view.dart';


Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashScreen(),
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
    Routes.estadisticas: (context) => const EstadisticasView(),
    Routes.perfil: (context) => const ProfileAdminView(),
    Routes.tiempoEstacionamiento: (context) => const TiempoEstacionamientoView(),
    Routes.preferencias: (context) => const PreferenciasView(),
    Routes.permanencia: (context) => const PermanenciaView(),
    Routes.reset_password: (context) => const ResetPasswordPage(),
  };
}