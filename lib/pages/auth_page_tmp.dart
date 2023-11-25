import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Authentication page!");

    return Scaffold(
      body: FirebaseAuth.instance.isSignedIn
          ? const Placeholder()
          : const Placeholder(),
    );
  }
}
