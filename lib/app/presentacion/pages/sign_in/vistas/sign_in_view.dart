import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:park_waze/app/data/services/push_notification.dart';
import 'package:park_waze/app/presentacion/pages/sign_in/vistas/sign_in_mixin.dart';
import 'package:park_waze/app/providers/signin_provider.dart';
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
  final List<String> _marcas = ['Ford', 'Chevrolet', 'Toyota', 'Honda', 'BMW'];
  List<String> _modeloDeLaMarca = [];

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
          const SnackBar(
              content:
                  Text("Debe seleccionar una marca y modelo del vehículo")),
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
          const SnackBar(
              content:
                  Text("El correo ingresado está vinculado a otra cuenta.")),
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
          const SnackBar(
              content: Text("La patente que ingresó ya se encuentra en uso")),
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
        await signInProvider.registerUser(
          nombreCompleto: _nombreCompleto.text,
          email: _correoElectronico.text,
          fechaNacimiento: DateFormat('dd/MM/yyyy').format(dateBirth),
          edad: edad,
          password: _contrasenha.text,
          role: UserRole.user,
          marca: _marcaSeleccionada!,
          modelo: _modeloSeleccionado!,
          patente: _patente.text,
          createdAt: formatedDate,
          token: token!,
          onError: (error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(error)));
          },
        );
        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Revise su correo para verificar su cuenta")));
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
        title: const Text("Registrarse"),
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
                TextFormField(
                  controller: _nombreCompleto,
                  decoration:
                      const InputDecoration(labelText: 'Nombre Completo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingrese su nombre completo.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _correoElectronico,
                  decoration:
                      const InputDecoration(labelText: 'Correo Electrónico'),
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _fechaNacimientoController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Nacimiento',
                    hintText: 'DD/MM/AAAA',
                  ),
                  readOnly: true,
                  onTap: () => selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa tu fecha de nacimiento.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _contrasenha,
                  decoration: const InputDecoration(labelText: 'Contraseña'),
                  obscureText: true,
                  validator: (value) =>
                      passwordValidator(value, _confirmarContra.text),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                TextFormField(
                  controller: _confirmarContra,
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Contraseña'),
                  obscureText: true,
                  validator: (value) =>
                      passwordValidator(value, _contrasenha.text),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                DropdownButtonFormField<String>(
                  value: _marcaSeleccionada,
                  decoration:
                      const InputDecoration(labelText: 'Marca del Vehículo'),
                  onChanged: _onMarcaChanged,
                  items: _marcas.map<DropdownMenuItem<String>>((String marca) {
                    return DropdownMenuItem<String>(
                      value: marca,
                      child: Text(marca),
                    );
                  }).toList(),
                  validator: (value) =>
                      value == null ? 'Por favor seleccione una marca' : null,
                ),
                DropdownButtonFormField<String>(
                  value: _modeloSeleccionado,
                  decoration:
                      const InputDecoration(labelText: 'Modelo del Vehículo'),
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
                      value == null ? 'Por favor seleccione un modelo' : null,
                ),
                TextFormField(
                  controller: _patente,
                  decoration:
                      const InputDecoration(labelText: 'Patente del Vehículo'),
                  validator: patenteValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: saveUserAndVehicle,
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
