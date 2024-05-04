import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { notAuthentication, chaeking, authenticated }

class LoginProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthStatus authStatus = AuthStatus.notAuthentication;

  Future<void> loginUser({
    required String email,
    required String password,
    required Function onSucces,
    required Function(String) onError,
  }) async {
    try {
      authStatus = AuthStatus.chaeking;
      notifyListeners();
      final String emailLowerCase = email.toLowerCase();
      final QuerySnapshot result = await _firestore
          .collection('Usuarios')
          .where('correoElectronico', isEqualTo: emailLowerCase)
          .limit(1)
          .get();
      if (result.docs.isNotEmpty) {
        final String correo = result.docs.first.get('correoElectronico');
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: email, password: password);
        onSucces();
        return;
      }
      onError('No se encontró el email ingresado. ');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-notfound' || e.code == 'wrong-password') {
        onError('Email o contraseña incorrecto.');
      } else {
        onError(e.toString());
      }
    } catch (e) {
      onError(e.toString());
    }
  }

  //Verificar estado
  void checkAuthState() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        authStatus = AuthStatus.notAuthentication;
      } else {
        authStatus = AuthStatus.authenticated;
      }
      notifyListeners();
    });
  }

  //Obtener datos del usuario
  Future<dynamic> getUserData(String email) async {
    final QuerySnapshot<Map<String, dynamic>> result = await _firestore
        .collection('Usuarios')
        .where('correoElectronico', isEqualTo: email)
        .limit(1)
        .get();
    if (result.docs.isNotEmpty) {
      final userData = result.docs[0].data();
      return userData;
    }
    return null;
  }
}
