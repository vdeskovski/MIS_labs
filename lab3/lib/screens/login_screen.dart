import 'package:flutter/material.dart';
import 'package:lab3/screens/register_screen.dart';

import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _isObscured;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isObscured = true;
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  bool isValidEmail(String email) {
    RegExp emailReg =
        RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+', caseSensitive: false);
    return emailReg.hasMatch(email);
  }

  void onSubmit() async {
    await AuthService()
        .login(emailController.text, passwordController.text, context);
  }

  void showRegisterScreen() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
                  child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.black12,
                        labelText: "Email",
                        hintText: "Enter email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is mandatory.";
                      } else if (!isValidEmail(value)) {
                        return "Email is not valid! Try again!";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
                  child: TextFormField(
                      controller: passwordController,
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        focusColor: Colors.black12,
                        labelText: "Password",
                        hintText: "Enter password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                            icon: _isObscured
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is mandatory.";
                        } else if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        return null;
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: showRegisterScreen,
                        child: const Text("Don't have an account? Register.")),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                        onPressed: onSubmit, child: const Text("Sign in"))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
