import 'package:flutter/material.dart';
import 'package:park_waze/app/presentacion/vista_admin/permanencia_view.dart';
import 'package:park_waze/app/presentacion/vista_admin/preferencias_view.dart';
import 'package:park_waze/app/presentacion/vista_admin/tiempo_estacionamiento_view.dart';

class EstadisticasView extends StatelessWidget {
  const EstadisticasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TiempoEstacionamientoView()),
                );
              },
              child: const Text('Ver estadísticas de tiempo de estacionamiento'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PreferenciasView()),
                );
              },
              child: const Text('Ver preferencias de usuarios'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PermanenciaView()),
                );
              },
              child: const Text('Ver permanencia del vehículo'),
            ),
          ],
        ),
      ),
    );
  }
}
