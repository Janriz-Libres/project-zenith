import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_zenith/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(
      'AIzaSyBoCBbW-wmUlBDZ7dUblzEpsbAJwpYP6rU', VolatileStore());
  Firestore.initialize('zenith-af3c4');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email = prefs.getString('email');

  if (email != null) {
    currentUser =
        await Authenticator.signIn(email, prefs.getString('pw') as String);

    await initializeModels();
  }

  runApp(const MyApp());

  doWhenWindowReady(() {
    const initialSize = Size(1335, 700);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Zenith";
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenith',
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) => currentUser != null
            ? HomePage(
                emailAddress: currentUser!.email,
                username: currentUser!.username,
              )
            : const AuthPage(),
      ),
    );
  }
}
