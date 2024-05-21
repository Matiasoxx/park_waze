import 'package:flutter/material.dart';

class TiempoEstacionamientoView extends StatelessWidget {
  const TiempoEstacionamientoView({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de muestra para el tiempo de estacionamiento
    final estacionamientos = [
      {
        'Piso': '3',
        'Pos': 'A1',
        'TiempoEsI': DateTime.parse('2024-05-15 05:20:57'),
        'TiempoEsF': DateTime.parse('2024-05-15 05:20:40'),
      },
      {
        'Piso': '1',
        'Pos': 'A1',
        'TiempoEsI': DateTime.parse('2024-05-14 14:20:57'),
        'TiempoEsF': DateTime.parse('2024-05-14 14:20:40'),
      },
      {
        'Piso': '2',
        'Pos': 'C4',
        'TiempoEsI': DateTime.parse('2024-05-15 05:20:57'),
        'TiempoEsF': DateTime.parse('2024-05-15 05:20:40'),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Tiempo de Estacionamiento'),
      ),
      body: ListView.builder(
        itemCount: estacionamientos.length,
        itemBuilder: (context, index) {
          final estacionamiento = estacionamientos[index];
          final tiempoEsI = estacionamiento['TiempoEsI'] as DateTime?;
          final tiempoEsF = estacionamiento['TiempoEsF'] as DateTime?;

          String tiempoBusquedaTexto = 'Datos incompletos';
          if (tiempoEsI != null && tiempoEsF != null) {
            final tiempoBusqueda = tiempoEsF.difference(tiempoEsI);
            tiempoBusquedaTexto = '${tiempoBusqueda.inMinutes} minutos';
          }

          return Card(
            margin: const EdgeInsets.all(10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Piso: ${estacionamiento['Piso']}'),
                  Text('Posición: ${estacionamiento['Pos']}'),
                  Text('Tiempo de Búsqueda: $tiempoBusquedaTexto'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
