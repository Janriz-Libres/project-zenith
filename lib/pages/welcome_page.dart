import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Image.asset("assets/left_bg.png"),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Image.asset("assets/right_bg.png"),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 80, bottom: 80, left: 120, right: 120),
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
        ),
      ],
    );
  }
}
