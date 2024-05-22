import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PermanenciaView extends StatelessWidget {
  const PermanenciaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permanencia del Vehículo'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Estacionamientos').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final estacionamientos = snapshot.data!.docs;
          return ListView.builder(
            itemCount: estacionamientos.length,
            itemBuilder: (context, index) {
              final estacionamiento = estacionamientos[index];
              final tiempoEn = (estacionamiento['TiempoEn'] as Timestamp?)?.toDate();
              final tiempoSa = (estacionamiento['TiempoSa'] as Timestamp?)?.toDate();

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
          );
        },
      ),
    );
  }
}
