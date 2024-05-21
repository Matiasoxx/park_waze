import 'package:flutter/material.dart';

class PreferenciasView extends StatelessWidget {
  const PreferenciasView({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de muestra para las preferencias de los usuarios
    final estacionamientos = [
      {
        'Piso': '3',
        'Pos': 'A1',
        'Solicitudes': 5,
      },
      {
        'Piso': '1',
        'Pos': 'A1',
        'Solicitudes': 3,
      },
      {
        'Piso': '2',
        'Pos': 'C4',
        'Solicitudes': 5,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias de los Usuarios'),
      ),
      body: ListView.builder(
        itemCount: estacionamientos.length,
        itemBuilder: (context, index) {
          final estacionamiento = estacionamientos[index];

          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Piso: ${estacionamiento['Piso']}'),
                  Text('Posición: ${estacionamiento['Pos']}'),
                  Text('Solicitudes: ${estacionamiento['Solicitudes']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
