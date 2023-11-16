import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/pages/login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirebaseAuth.instance.isSignedIn
          ? const HomePage()
          : const LoginPage(),
    );
  }
}
