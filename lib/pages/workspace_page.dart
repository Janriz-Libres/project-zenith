import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/buildworkspace_page.dart';

class Workspace extends StatelessWidget {
  const Workspace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset("assets/left_bg.png"),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset("assets/right_bg.png"),
          ),
          const Padding(
            padding:
                EdgeInsets.only(top: 18, bottom: 80, left: 120, right: 120),
            child: BuildWorkspace(),
          ),
          const Copyright(mLeft: 85, mBot: 30),
        ],
      ),
    );
  }
}
