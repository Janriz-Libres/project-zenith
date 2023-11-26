import 'package:flutter/material.dart';

class BuildWorkspace extends StatelessWidget {
  const BuildWorkspace({super.key});

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
                child: const Column(
                  children: [
                    SizedBox(
                      width: 1040,
                      height: 74,
                      child: Text(
                        'Let’s Build a Workspace!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 60,
                          fontFamily: 'Work Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1040,
                      height: 20,
                      child: Text(
                        'Crusader Yearbook',
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
                    SizedBox(
                      width: 420,
                      height: 20,
                      child: Text(
                        'Workspace Name:',
                        style: TextStyle(
                          color: Color(0xFFFFE66D),
                          fontSize: 15,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ]),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset("assets/signup_ellipse.png"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
