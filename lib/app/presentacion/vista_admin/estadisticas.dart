import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:park_waze/app/presentacion/utils/update_parking_data.dart'; // Asegúrate de importar correctamente
>>>>>>> main
import 'package:park_waze/app/presentacion/vista_admin/permanencia_view.dart';
import 'package:park_waze/app/presentacion/vista_admin/preferencias_view.dart';
import 'package:park_waze/app/presentacion/vista_admin/tiempo_estacionamiento_view.dart';

<<<<<<< HEAD
=======

>>>>>>> main
class EstadisticasView extends StatelessWidget {
  const EstadisticasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(
        title: const Text('Estadísticas'),
      ),
=======
>>>>>>> main
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
<<<<<<< HEAD
=======
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await addRandomParkingData();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Nuevo documento de estacionamiento añadido')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text('Añadir Estacionamiento Aleatorio'),
            ),
>>>>>>> main
          ],
        ),
      ),
    );
  }
<<<<<<< HEAD
}

=======
}
>>>>>>> main
