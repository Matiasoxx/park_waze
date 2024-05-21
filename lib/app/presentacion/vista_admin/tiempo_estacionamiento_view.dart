import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TiempoEstacionamientoView extends StatelessWidget {
  const TiempoEstacionamientoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Tiempo de Estacionamiento'),
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
              final tiempoEsI = (estacionamiento['TiempoEsI'] as Timestamp?)?.toDate();
              final tiempoEsF = (estacionamiento['TiempoEsF'] as Timestamp?)?.toDate();

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
          );
        },
      ),
    );
  }
}
