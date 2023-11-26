import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

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
        Padding(
          padding:
              const EdgeInsets.only(top: 18, bottom: 80, left: 120, right: 120),
          child: Stack(
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
                child: const LandingImage(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/white_logo.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LandingImage extends StatelessWidget {
  const LandingImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/landing_img.png");
  }
}
