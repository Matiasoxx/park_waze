import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreferenciasView extends StatelessWidget {
  const PreferenciasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias de los Usuarios'),
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
              final piso = estacionamiento['Piso'] ?? 'Desconocido';
              final pos = estacionamiento['Pos'] ?? 'Desconocida';
              final solicitudes = estacionamiento['Solicitudes'] ?? 0;

              return Card(
                margin: const EdgeInsets.all(10.0),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Piso: $piso'),
                      Text('Posición: $pos'),
                      Text('Solicitudes: $solicitudes'),
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
