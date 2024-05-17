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
              await LocalStorage()
                  .saveUserData(_emailController.text, _passController.text);
              await LocalStorage().setIsSignedIn(true);
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
                      color: Colors.black,
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
                    prefixIcon: const Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return S.of(context).validPass;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    onFormLogin(
                        _emailController.text, _passController.text, context);
                  },
                  child: Text(S.of(context).ingresar),
                ),
              ],
            ).animate().fade(),
          ),
        ),
      ),
    );
  }
}
