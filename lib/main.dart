import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FirebaseAuth.initialize(
  //     'AIzaSyBoCBbW-wmUlBDZ7dUblzEpsbAJwpYP6rU', VolatileStore());
  // Firestore.initialize('zenith-af3c4');
  // await Authenticator.signIn('test_user@gmail.com', 'test_pw');

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
    return const MaterialApp(
      title: 'Zenith',
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
