import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:park_waze/app/data/services/local_storage.dart';
import 'package:park_waze/app/presentacion/pages/home/views/home_view.dart';
import 'package:park_waze/app/providers/login_provider.dart';
import 'package:park_waze/generated/l10n.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passFocusNode = FocusNode();

  bool _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  void onFormLogin(String email, String password, context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final String emailLower = email.toLowerCase();

      loginProvider.loginUser(
          email: emailLower,
          password: password,
          onSucces: (String role) async {
            User? user = FirebaseAuth.instance.currentUser;
            if (user != null && user.emailVerified) {
              setState(() {
                _isLoading = false;
              });
              dynamic userData = await loginProvider.getUserData(user.email!);
              await LocalStorage().saveUserData(
                _emailController.text.trim(),
                _passController.text,
              );
              await LocalStorage().setIsSignedIn(true);
              await LocalStorage().saveRole(role);
              loginProvider.checkAuthState();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomeView(userData: userData, role: role);
              }));
            } else {
              setState(() {
                _isLoading = false;
              });
              await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text(S.of(context).taVerifyEmail),
                      content: Text(S.of(context).aVerifyEmailBody),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(S.of(context).bAceptarButton)),
                      ],
                    );
                  });
            }
          },
          onError: (String error) {
            setState(() {
              _isLoading = false;
            });
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error"),
                    content: Text(error),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(S.of(context).bAceptarButton)),
                    ],
                  );
                });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      backgroundColor: Colors.black,
=======
>>>>>>> main
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    S.of(context).bLogin,
                    style: const TextStyle(
<<<<<<< HEAD
                      color: Colors.white,
=======
                      color: Colors.black,
>>>>>>> main
                      fontSize: 34.0, // Tamaño de la fuente
                      fontWeight: FontWeight.bold, // Grosor de la fuente
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    labelText: S.of(context).lCorreo,
<<<<<<< HEAD
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.email, color: Colors.white),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
=======
                    prefixIcon: const Icon(Icons.email),
                  ),
>>>>>>> main
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (_emailController.text != value.replaceAll(' ', '')) {
                      _emailController.text = value.replaceAll(' ', '');
                      _emailController.selection = TextSelection.fromPosition(
                        TextPosition(offset: _emailController.text.length),
                      );
                    }
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.endsWith('@gmail.com')) {
                      return S.of(context).validMail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passController,
                  focusNode: _passFocusNode,
                  decoration: InputDecoration(
                    labelText: S.of(context).lContra,
<<<<<<< HEAD
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
=======
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
>>>>>>> main
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
<<<<<<< HEAD
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
=======
                  ),
>>>>>>> main
                  onChanged: (value) {
                    _passController.text = value.replaceAll(' ', '');
                    _passController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _passController.text.length),
                    );
                  },
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return S.of(context).validPass;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                TextButton(
<<<<<<< HEAD
                  onPressed: () {
                    Navigator.pushNamed(context, '/reset-pass');
                  },
                  child: Text(
                    S.of(context).forgotPassw,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text color
                  ),
=======
                    onPressed: () {
                      Navigator.pushNamed(context, '/reset-pass');
                    },
                    child: Text(S.of(context).forgotPassw)),
                ElevatedButton(
>>>>>>> main
                  onPressed: () {
                    onFormLogin(
                        _emailController.text, _passController.text, context);
                  },
                  child: Text(S.of(context).ingresar),
                ),
<<<<<<< HEAD
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white, // Text color
                  ),
=======
                ElevatedButton(
>>>>>>> main
                  onPressed: () {
                    Navigator.pushNamed(context, "/sign-in");
                  },
                  child: Text(S.of(context).bRegister),
                ),
              ],
            ).animate().fade(),
          ),
        ),
      ),
    );
  }
}
