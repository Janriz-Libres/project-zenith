import 'package:flutter/material.dart';
import 'package:firedart/firedart.dart';
import 'package:project_zenith/pages/auth_page.dart';
// import 'package:project_zenith/pages/home_page.dart';
// import 'package:project_zenith/pages/login_page.dart';
import 'package:project_zenith/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(
      'AIzaSyBoCBbW-wmUlBDZ7dUblzEpsbAJwpYP6rU', VolatileStore());
  Firestore.initialize('zenith-af3c4');
  User currentUser =
      await Authenticator.signIn('test_user@gmail.com', 'test_pw');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenith',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const AuthPage(),
    );
  }
}
