import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          children: [
            Text(
              "SIGN UP",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 60,
                fontFamily: 'Work Sans',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            Text(
              "Crusader Yearbook",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            )
          ],
        ),
        const Column(
          children: [
            InputWidget(
              circleColor: Color(0xFF06BCC1),
            ),
            InputWidget(
              circleColor: Color(0xFFD4515D),
            ),
            InputWidget(
              circleColor: Color(0xFFFFE66D),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10, bottom: 10),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 1, color: Color(0xFFC2C2C2)),
                      borderRadius: BorderRadius.circular(4))),
              child: Checkbox(
                value: false,
                side: BorderSide.none,
                onChanged: (value) {},
              ),
            ),
            const Text(
              "I've read and agree to Terms & Conditions",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
              colors: [
                Color(0xFF06BCC1),
                Color(0xFF047679),
              ],
            ),
            shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 4,
                  strokeAlign: BorderSide.strokeAlignCenter,
                  color: Color(0xFF06BCC1),
                ),
                borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            "Create Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        )
      ],
    );
  }
}

class InputWidget extends StatelessWidget {
  final Color circleColor;

  const InputWidget({
    super.key,
    required this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          )),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            margin:
                const EdgeInsets.only(top: 13, bottom: 13, left: 20, right: 11),
            decoration: ShapeDecoration(
              color: circleColor,
              shape: const OvalBorder(),
            ),
          ),
          Container(
            width: 338,
            height: 50,
            decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    width: 4,
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(50),
                )),
          ),
        ],
      ),
    );
  }
}
