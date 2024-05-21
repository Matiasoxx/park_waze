import 'package:flutter/material.dart';

class PermanenciaView extends StatelessWidget {
  const PermanenciaView({super.key});

  @override
  Widget build(BuildContext context) {
    // Datos de muestra para la permanencia de los vehículos
    final estacionamientos = [
      {
        'Piso': '3',
        'Pos': 'A1',
        'TiempoEn': DateTime.parse('2024-05-15 05:18:45'),
        'TiempoSa': DateTime.parse('2024-05-15 07:20:35'),
      },
      {
        'Piso': '1',
        'Pos': 'A1',
        'TiempoEn': DateTime.parse('2024-05-14 14:18:45'),
        'TiempoSa': DateTime.parse('2024-05-14 16:20:35'),
      },
      {
        'Piso': '2',
        'Pos': 'C4',
        'TiempoEn': DateTime.parse('2024-05-15 05:18:45'),
        'TiempoSa': DateTime.parse('2024-05-15 07:20:35'),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Permanencia del Vehículo'),
      ),
      body: ListView.builder(
        itemCount: estacionamientos.length,
        itemBuilder: (context, index) {
          final estacionamiento = estacionamientos[index];
          final tiempoEn = estacionamiento['TiempoEn'] as DateTime?;
          final tiempoSa = estacionamiento['TiempoSa'] as DateTime?;

          String tiempoTotalPermanenciaTexto = 'Datos incompletos';
          if (tiempoEn != null && tiempoSa != null) {
            final tiempoTotalPermanencia = tiempoSa.difference(tiempoEn);
            tiempoTotalPermanenciaTexto = '${tiempoTotalPermanencia.inMinutes} minutos';
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
                  Text('Tiempo Total de Permanencia: $tiempoTotalPermanenciaTexto'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
