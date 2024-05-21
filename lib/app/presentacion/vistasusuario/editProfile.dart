import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  final dynamic userData;

  const EditProfile({super.key, required this.userData});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _profileImageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['fullName']);
    _ageController = TextEditingController(text: widget.userData['age']);
    _profileImageController =
        TextEditingController(text: widget.userData['profileImage']);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _profileImageController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Lógica para guardar el perfil editado
    setState(() {
      widget.userData['fullName'] = _nameController.text;
      widget.userData['age'] = _ageController.text;
      widget.userData['profileImage'] = _profileImageController.text;
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
