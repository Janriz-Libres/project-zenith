import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Welcome to Zenith",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontFamily: 'Work Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -5),
                      child: const Text(
                        "Crusader Yearbook",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(child: Container()),
                const Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WelcomeButton(
                        text: "Build a Workspace?",
                        imgPath: "assets/build_icon.png",
                        btnColors: [Color(0xFF06BCC1), Color(0xFF168285)],
                      ),
                      WelcomeButton(
                        text: "Join a Workspace?",
                        imgPath: "assets/join_icon.png",
                        btnColors: [Color(0xFFD4515D), Color(0xFFB12935)],
                      ),
                      WelcomeButton(
                        text: "I'll do this later!",
                        imgPath: "assets/later_icon.png",
                        btnColors: [Color(0xFFFFE66D), Color(0xFF927E1D)],
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/white_logo.png"),
        ),
      ],
    );
  }
}

class WelcomeButton extends StatelessWidget {
  final String imgPath;
  final String text;
  final List<Color> btnColors;

  const WelcomeButton({
    super.key,
    required this.imgPath,
    required this.text,
    required this.btnColors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imgPath,
          width: 60,
          height: 60,
        ),
        Container(
          width: 364,
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0, -1),
              end: const Alignment(0, 1),
              colors: btnColors,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 4, color: btnColors.first),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }
}
