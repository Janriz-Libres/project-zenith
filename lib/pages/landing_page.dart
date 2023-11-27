import 'package:flutter/material.dart';
import 'package:project_zenith/pages/welcome_page.dart';
import 'package:project_zenith/widgets/copyright_mark.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
            child: WelcomePage(),
          ),
          const Copyright(mLeft: 85, mBot: 30),
        ],
      ),
    );
  }
}

class LandingContent extends StatelessWidget {
  const LandingContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 62),
          decoration: const ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.white,
              ),
            ),
          ),
          child: Image.asset("assets/landing_img.png"),
        ),
      ],
    );
  }
}
