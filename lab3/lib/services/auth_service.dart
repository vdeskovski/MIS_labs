import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab3/screens/login_screen.dart';

import '../screens/joke_type_list_screen.dart';

class AuthService {
  Future<Map<String, dynamic>> register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
      return {"status": "Success", "user": userCredential.user};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {"status": "The password provided is too weak.", "user": null};
      } else if (e.code == 'email-already-in-use') {
        return {
          "status": "The account already exists for that email.",
          "user": null
        };
      } else {
        return {"status": e.message, "user": null};
      }
    } catch (e) {
      return {"status": e.toString(), "user": null};
    }
  }

  Future<String?> login(
      String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context, rootNavigator: true)
          .push(MaterialPageRoute(builder: (ctx) => JokeTypeListScreen()));
      return "Success";
    } on FirebaseAuthException catch (e) {
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        return "Email/password is incorrect";
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (ctx) => const LoginScreen()));
  }

  String getUserEmail() {
    var userEmail = FirebaseAuth.instance.currentUser?.email ?? "No email";
    return userEmail;
  }
}
