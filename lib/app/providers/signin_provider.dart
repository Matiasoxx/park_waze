import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

enum UserRole { admin, user }

class SignInProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> registerUser(
      {required String nombreCompleto,
      required String email,
      required String fechaNacimiento,
      required int edad,
      required String password,
      required UserRole role,
      required String marca,
      required String modelo,
      required String patente,
      required String token,
      required Function(String) onError,
      required String createdAt,
      String? profileImageUrl}) async {
    try {
      final String emailLower = email.toLowerCase();
      final bool emailexist = await checkEmailExist(emailLower);
      if (emailexist) {
        onError('El email ya se encuentra en uso');
        return;
      }

      //Verificar poderes del usuario
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user!;
      final String userId = user.uid;

      //Subir imagen al storage

      await _firestore.collection('Usuarios').doc(userId).set({
        'id': userId,
        'nombreCompleto': nombreCompleto,
        'correoElectronico': emailLower,
        'fechaNacimiento': fechaNacimiento,
        'edad': edad,
        'rol': describeEnum(role),
        'createdAt': FieldValue.serverTimestamp(),
        'token': token,
        'profileImageUrl': profileImageUrl,
      });
      final bool patenteExist = await checkPatenteExist(patente);
      if (patenteExist) {
        onError('La patente que ingreso ya se encuentra en uso');
        return;
      }
      await _firestore.collection('Vehiculos').add({
        'userId': userId,
        'marca': marca,
        'modelo': modelo,
        'patente': patente,
      });
    } catch (e) {
      onError('Ocurrio un error al registrar el usuario');
    }
  }

  //Metodo verificar si el email esta existente en la base de datos
  Future<bool> checkEmailExist(String emailLow) async {
    final QuerySnapshot result = await _firestore
        .collection('Usuarios')
        .where('correoElectronico', isEqualTo: emailLow)
        .limit(1)
        .get();
    return result.docs.isNotEmpty;
  }

  Future<String> uploadProfileImage(File image) async {
    final String fileName = 'profileImages/${_auth.currentUser!.uid}.jpg';
    final UploadTask uploadTask = _storage.ref().child(fileName).putFile(image);
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  //Metodo ver si la patente esta siendo usada
  Future<bool> checkPatenteExist(String patente) async {
    final QuerySnapshot result = await _firestore
        .collection('vehiculos')
        .where('patente', isEqualTo: patente)
        .limit(1)
        .get();
    return result.docs.isNotEmpty;
  }
}
