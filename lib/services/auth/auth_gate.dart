import 'package:echo_wall/pages/gnav_home_page.dart';
import 'package:echo_wall/pages/home_page.dart';
import 'package:echo_wall/services/auth/login_or_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GnavHomePage();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
