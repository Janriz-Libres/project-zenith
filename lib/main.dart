import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

User? currentUser;
List<Workspace>? ownedWorkspaces;
List<Workspace>? sharedWorkspaces;
List<WorkList>? lists;
List<Task>? tasks;

void initializeModels() async {
  ownedWorkspaces = await currentUser?.getOwnedWorkspaces();
  sharedWorkspaces = await currentUser?.getSharedWorkspaces();

  if (ownedWorkspaces != null) {
    for (Workspace space in ownedWorkspaces!) {
      lists?.addAll(await space.getLists());
    }
  }

  if (sharedWorkspaces != null) {
    for (Workspace space in sharedWorkspaces!) {
      lists?.addAll(await space.getLists());
    }
  }

  if (lists != null) {
    for (WorkList list in lists!) {
      tasks?.addAll(await list.getTasks());
    }
  }
}

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

    initializeModels();
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
        builder: (context, constraints) =>
            currentUser != null ? HomePage(emailAddress: currentUser!.email, username: currentUser!.username,) : const AuthPage(),
      ),
    );
  }
}
