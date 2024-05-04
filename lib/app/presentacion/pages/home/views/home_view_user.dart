import 'package:flutter/material.dart';

class HomeViewUser extends StatelessWidget {
  final dynamic userData;

  const HomeViewUser({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido ${userData['name']}',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20),
            Text(
              'Correo Electrónico: ${userData['email']}',
              style: const TextStyle(fontSize: 16.0),
            ),
            // Otros widgets según la información de userData
          ],
        ),
      ),
    );
  }
}
