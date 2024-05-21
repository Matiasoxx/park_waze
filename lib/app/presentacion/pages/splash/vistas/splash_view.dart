import 'package:flutter/material.dart';
import 'package:park_waze/app/data/services/local_storage.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_admin.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view_user.dart';
import 'package:park_waze/app/presentacion/pages/login/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final isSignedIn = await LocalStorage().getIsSignedIn();
    final userData = await LocalStorage().getUserData();
    final userRole = await LocalStorage().getRole();

    if (isSignedIn && userData != null && userRole != null) {
      if (userRole == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeViewUser(userData: userData)),
        );
      } else if (userRole == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomeViewAdmin(userData: userData)),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
