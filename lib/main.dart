import 'package:flutter/material.dart';
import 'package:project_zenith/pages/landing_page.dart';
// import 'package:project_zenith/pages/auth_page.dart';
// import 'package:firedart/firedart.dart';
// import 'package:project_zenith/pages/auth_page.dart';
// import 'package:project_zenith/pages/landing_page.dart';
// import 'package:project_zenith/pages/signup_page.dart';
// import 'package:project_zenith/pages/welcome_page.dart';
// import 'package:project_zenith/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseAuth.initialize(
  //     'AIzaSyBoCBbW-wmUlBDZ7dUblzEpsbAJwpYP6rU', VolatileStore());
  // Firestore.initialize('zenith-af3c4');
  // await Authenticator.signIn('test_user@gmail.com', 'test_pw');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Zenith',
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
