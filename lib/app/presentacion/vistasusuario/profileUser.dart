import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:park_waze/app/data/services/local_storage.dart';
import 'package:park_waze/app/providers/localeProvider.dart';
import 'package:park_waze/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String currentLanguageCode = 'en';

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    ageController = TextEditingController();
    _loadUserData();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      currentLanguageCode = prefs.getString('language_code') ?? 'en';
    });
  }

  Future<void> _changeLanguage(String newLanguageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', newLanguageCode);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    localeProvider.setLocale(Locale(newLanguageCode));
    setState(() {
      currentLanguageCode = newLanguageCode;
    });
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
            '${S.of(context).fullNam}: ${fullNameController.text}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            '${S.of(context).edad}: ${ageController.text}',
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
            label: Text(S.of(context).editProf),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          Text(S.of(context).chLengu),
          DropdownButton<String>(
            value: currentLanguageCode,
            onChanged: (String? newValue) {
              if (newValue != null && newValue != currentLanguageCode) {
                _changeLanguage(newValue);
              }
            },
            items: <String>['en', 'es']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value == 'en' ? S.of(context).english : S.of(context).spanish,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: Text(S.of(context).logout),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _deleteAccount,
            icon: const Icon(Icons.delete),
            label: Text(S.of(context).deletAcc),
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
        '/homeh'); // Asegúrate de que '/login' sea la ruta correcta
  }

  Future<void> _deleteAccount() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('Usuarios')
          .doc(user.uid)
          .delete();
      await user.delete();
      Navigator.of(context).pushReplacementNamed('/homeh');
    }
  }
}
