import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:welcome_todo/login_registerpage.dart';
import 'package:welcome_todo/welcomepage.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return WelcomePage();
          }

          // user is NOT logged in
          else {
            return LoginorRegister();
          }
        },
      ),
    );
  }
}