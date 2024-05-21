import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:park_waze/app/data/services/push_notification.dart';
import 'package:park_waze/app/presentacion/pages/sign_in/vistas/sign_in_mixin.dart';
import 'package:park_waze/app/providers/signin_provider.dart';
import 'package:park_waze/generated/l10n.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with SignInMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreCompleto = TextEditingController();
  final TextEditingController _correoElectronico = TextEditingController();
  final TextEditingController _fechaNacimientoController =
      TextEditingController();
  final TextEditingController _contrasenha = TextEditingController();
  final TextEditingController _confirmarContra = TextEditingController();
  final TextEditingController _modelo = TextEditingController();
  final TextEditingController _patente = TextEditingController();
  String? _marcaSeleccionada;
  String? _modeloSeleccionado;
  final List<String> _marcas = [
    'Ford',
    'Chevrolet',
    'Toyota',
    'Honda',
    'BMW',
    'Nissan',
    'Volkswagen',
    'Mercedes-Benz',
    'Audi',
    'Hyundai'
  ];
  List<String> _modeloDeLaMarca = [];
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  final bool _isObscure = true;
  bool _isLoading = false;
  static String? token;

  @override
  void initState() {
    super.initState();
    token = PushNotificationService.token;
  }

  @override
  void dispose() {
    _nombreCompleto.dispose();
    _correoElectronico.dispose();
    _fechaNacimientoController.dispose();
    _contrasenha.dispose();
    _confirmarContra.dispose();
    _modelo.dispose();
    _patente.dispose();
    super.dispose();
  }

  void _onMarcaChanged(String? newMarca) {
    setState(() {
      _marcaSeleccionada = newMarca;
      _modeloDeLaMarca = getModelosPorMarca(newMarca ??
          ''); // Asegúrate de que esta función retorne los modelos correctos
      _modeloSeleccionado =
          null; // Esencial para resetear el modelo seleccionado cuando la marca cambia
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> saveUserAndVehicle() async {
    final signInProvider = Provider.of<SignInProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      if (_marcaSeleccionada == null || _modeloSeleccionado == null) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).marcAndModelRequired)),
        );
        return;
      }

      final bool existUserEmail =
          await signInProvider.checkEmailExist(_correoElectronico.text);
      if (existUserEmail) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).correoExist)),
        );
        return;
      }

      final bool existPatent =
          await signInProvider.checkPatenteExist(_patente.text);
      if (existPatent) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).patenteExist)),
        );
        return;
      }

      final now = DateTime.now();
      String formatedDate = DateFormat('dd/MM/yyyy').format(now);
      final birth = _fechaNacimientoController.text;

      DateTime dateBirth = DateFormat('dd/MM/yyyy').parse(birth);
      int edad = now.year - dateBirth.year;
      if (now.month < dateBirth.month ||
          (now.month == dateBirth.month && now.day < dateBirth.day)) {
        edad--;
      }

      try {
        String? profileImageUrl;
        if (_profileImage != null) {
          profileImageUrl =
              await signInProvider.uploadProfileImage(_profileImage!);
        }

        await signInProvider.registerUser(
          nombreCompleto: _nombreCompleto.text,
          email: _correoElectronico.text.trim(),
          fechaNacimiento: DateFormat('dd/MM/yyyy').format(dateBirth),
          edad: edad,
          password: _contrasenha.text.trim(),
          role: UserRole.user,
          marca: _marcaSeleccionada!,
          modelo: _modeloSeleccionado!,
          patente: _patente.text.toUpperCase().trim(),
          createdAt: formatedDate,
          token: token!,
          profileImageUrl: profileImageUrl,
          onError: (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error)));
          },
        );
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).reviewYourEmail)));
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
        setState(() {
          _isLoading = false;
        });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Ocurrió un error al registrar el usuario: ${e.toString()}")));
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != DateTime.now()) {
      _fechaNacimientoController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).titleRegister),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _profileImage == null
                    ? Text(S.of(context).noImagen)
                    : Image.file(_profileImage!),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text(S.of(context).imagenButton),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nombreCompleto,
                  decoration:
                      InputDecoration(labelText: S.of(context).labelName),
                  validator: (value) => nombreCompletoValidator(value, context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _correoElectronico,
                  decoration: InputDecoration(labelText: S.of(context).lCorreo),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => emailValidator(value, context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _fechaNacimientoController,
                  decoration: InputDecoration(
                    labelText: S.of(context).lFechaNacimiento,
                    hintText: 'DD/MM/AAAA',
                  ),
                  readOnly: true,
                  onTap: () => selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).lValidDate;
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contrasenha,
                  decoration: InputDecoration(labelText: S.of(context).lContra),
                  obscureText: true,
                  validator: (value) =>
                      passwordValidator(value, _confirmarContra.text, context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _confirmarContra,
                  decoration:
                      InputDecoration(labelText: S.of(context).lCContra),
                  obscureText: true,
                  validator: (value) =>
                      passwordValidator(value, _contrasenha.text, context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                DropdownButtonFormField<String>(
                  value: _marcaSeleccionada,
                  decoration: InputDecoration(labelText: S.of(context).lMarca),
                  onChanged: _onMarcaChanged,
                  items: _marcas.map<DropdownMenuItem<String>>((String marca) {
                    return DropdownMenuItem<String>(
                      value: marca,
                      child: Text(marca),
                    );
                  }).toList(),
                  validator: (value) =>
                      value == null ? S.of(context).lValidMarca : null,
                ),
                DropdownButtonFormField<String>(
                  value: _modeloSeleccionado,
                  decoration: InputDecoration(labelText: S.of(context).lModelo),
                  onChanged: (String? newModelo) {
                    setState(() {
                      _modeloSeleccionado = newModelo;
                    });
                  },
                  items: _modeloDeLaMarca
                      .map<DropdownMenuItem<String>>((String modelo) {
                    return DropdownMenuItem<String>(
                      value: modelo,
                      child: Text(modelo),
                    );
                  }).toList(),
                  validator: (value) =>
                      value == null ? S.of(context).lValidModelo : null,
                ),
                TextFormField(
                  controller: _patente,
                  decoration:
                      InputDecoration(labelText: S.of(context).lPatente),
                  validator: (value) => patenteValidator(value, context),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveUserAndVehicle,
                  child: Text(S.of(context).titleRegister),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
