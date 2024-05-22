import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addRandomParkingData() async {
  final firestore = FirebaseFirestore.instance;
  final estacionamientosCollection = firestore.collection('Estacionamientos');
  final vehiculosCollection = firestore.collection('Vehiculos');

  try {
    // Obtener todas las patentes de la colección Vehículos
    final vehiculosSnapshot = await vehiculosCollection.get();
    final patentes = vehiculosSnapshot.docs.map((doc) => doc.data()['patente'] as String).toList();

    if (patentes.isEmpty) {
      print('No se encontraron patentes en la colección Vehículos');
      return;
    }

    final random = Random();
    final List<String> pisos = ['1', '2', '3'];
    final List<String> posiciones = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

    // Generar datos aleatorios para un nuevo documento
    final String piso = pisos[random.nextInt(pisos.length)];
    final String pos = posiciones[random.nextInt(posiciones.length)];
    final String? patenteRef = random.nextBool() ? patentes[random.nextInt(patentes.length)] : null;
    final bool disponible = patenteRef == null;
    final String code = '$piso-$pos';

    await estacionamientosCollection.add({
      'Piso': piso,
      'Pos': pos,
      'Solicitudes': random.nextInt(10),
      'TiempoEn': Timestamp.now(),
      'TiempoEsF': Timestamp.now(),
      'TiempoEsI': Timestamp.now(),
      'TiempoSa': Timestamp.now(),
      'code': code,
      'disponible': disponible,
      'patente_ref': patenteRef,
      'discapacitado': random.nextBool(),
    });

    print('New document added: Piso: $piso, Pos: $pos, patente_ref: $patenteRef, disponible: $disponible, code: $code');
  } catch (e) {
    print('Error adding document: $e');
  }
}
Future<List<Map<String, dynamic>>> fetchParkingData() async {
  final estacionamientosCollection = FirebaseFirestore.instance.collection('Estacionamientos');
  final querySnapshot = await estacionamientosCollection.get();

  return querySnapshot.docs.map((doc) {
    final data = doc.data();

    // Manejar campos faltantes con valores predeterminados
    return {
      'Piso': data['Piso'] ?? '',
      'Pos': data['Pos'] ?? '',
      'Solicitudes': data['Solicitudes'] ?? 0,
      'TiempoEn': data['TiempoEn'] ?? Timestamp.now(),
      'TiempoEsF': data['TiempoEsF'] ?? Timestamp.now(),
      'TiempoEsI': data['TiempoEsI'] ?? Timestamp.now(),
      'TiempoSa': data['TiempoSa'] ?? Timestamp.now(),
      'code': data['code'] ?? '',
      'disponible': data['disponible'] ?? true,
      'patente_ref': data['patente_ref'],
      'discapacitado': data['discapacitado'] ?? false,
    };
  }).toList();
}
