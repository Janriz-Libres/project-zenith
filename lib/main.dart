import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
// import 'package:firedart/firedart.dart';
// import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/landing_page.dart';
import 'package:project_zenith/pages/buildworkspace_page.dart';
import 'package:project_zenith/pages/login_page.dart';
import 'package:project_zenith/pages/signup_page.dart';
// import 'package:project_zenith/utils.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseAuth.initialize(
  //     'AIzaSyBoCBbW-wmUlBDZ7dUblzEpsbAJwpYP6rU', VolatileStore());
  // Firestore.initialize('zenith-af3c4');
  // await Authenticator.signIn('test_user@gmail.com', 'test_pw');

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Zenith');
    setWindowMinSize(const Size(1335, 685));
  }

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
      home: BuildWorkspace(),
    );
  }
}
