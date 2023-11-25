import 'package:flutter/material.dart';
import 'package:project_zenith/pages/signup_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.all(25),
            decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
              width: 3,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Colors.white,
            ))),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/signup_image.png'),
                    const LeftPane(),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Crusader Yearbook ©️ 2023",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class LeftPane extends StatelessWidget {
  const LeftPane({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          child: Image.asset(
            'assets/signup_ellipse_cropped.png',
            alignment: Alignment.topRight,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 53, right: 53),
          child: Row(
            children: [
              Container(
                width: 26.67,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: 13.33,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                width: 6.67,
                margin: const EdgeInsets.only(right: 6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              const InputContainer(),
            ],
          ),
        ),
      ],
    );
  }
}

class InputContainer extends StatelessWidget {
  const InputContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 42, right: 42, top: 20, bottom: 30),
      decoration: const ShapeDecoration(
          color: Colors.black,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 4, color: Colors.white),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ))),
      child: const SignupPage(),
    );
  }
}
