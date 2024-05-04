import 'package:connectivity_plus/connectivity_plus.dart'; // Suponiendo que usas este paquete para la conectividad
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _init());
  }

  Future<void> _init() async {
    // Verificar la conexión a internet primero
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
      return;
    }

    // Autenticación y navegación
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null && auth.currentUser!.emailVerified) {
      Navigator.pushReplacementNamed(context,
          Routes.home); // Asume que esta es la ruta de la página principal
    } else {
      Navigator.pushReplacementNamed(context,
          Routes.signIn); // Asume que esta es la ruta de inicio de sesión
    }
  }

  void _showNoInternetDialog() {
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Sin conexión'),
          content: const Text(
              'No hay conexión a internet. Por favor, verifica tu conexión y vuelve a intentarlo.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _init(); // Reintenta inicializar
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
