import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_waze/app/data/services/local_storage.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key, required userData});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  bool isEditing = false;
  late TextEditingController fullNameController;
  late TextEditingController ageController;
  String profileImage = 'https://via.placeholder.com/150';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    ageController = TextEditingController();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
        setState(() {
          fullNameController.text = data?['nombreCompleto'] ?? '';
          ageController.text = data?['edad']?.toString() ?? '';
          profileImage =
              data?['profileImageUrl'] ?? 'https://via.placeholder.com/150';
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isEditing ? buildEditProfileView() : buildProfileView(),
      ),
    );
  }

  Widget buildProfileView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileImage),
          ),
          const SizedBox(height: 20),
          Text(
            'Nombre: ${fullNameController.text}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            'Edad: ${ageController.text}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                isEditing = true;
              });
            },
            icon: const Icon(Icons.edit),
            label: const Text('Editar Perfil'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          ElevatedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar Sesión'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _deleteAccount,
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar Cuenta'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEditProfileView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
              labelText: 'Nombre Completo',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: ageController,
            decoration: const InputDecoration(
              labelText: 'Edad',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                isEditing = false;
              });
              _saveUserData();
            },
            icon: const Icon(Icons.save),
            label: const Text('Guardar'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(user.uid)
          .update({
        'nombreCompleto': fullNameController.text,
        'edad': int.tryParse(ageController.text) ?? 0,
        'profileImageUrl': profileImage,
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    await LocalStorage().clearAll();
    Navigator.of(context).pushReplacementNamed(
        '/login'); // Asegúrate de que '/login' sea la ruta correcta
  }

  Future<void> _deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(user.uid)
          .delete();
      await user.delete();
      Navigator.of(context).pushReplacementNamed(
          '/login'); // Asegúrate de que '/login' sea la ruta correcta
    }
  }
}
