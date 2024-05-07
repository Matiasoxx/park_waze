import 'package:flutter/material.dart';

class HomeViewAdmin extends StatelessWidget {
  final dynamic userData;

  const HomeViewAdmin({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Admin'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido ${userData['nombreCompleto']}',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              'Correo Electrónico: ${userData['correoElectronico']}',
              style: const TextStyle(fontSize: 16.0),
            ),
            // Otros widgets según la información de userData
          ],
        ),
      ),
    );
  }
}
