import 'package:flutter/material.dart';
import 'package:project_zenith/subpages/login_page.dart';
import 'package:project_zenith/subpages/signup_page.dart';
import 'package:project_zenith/widgets/copyright_mark.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(25),
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 3,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Colors.white,
            ),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 70, right: 80, top: 13.5, bottom: 13.5),
                    child: Image.asset('assets/signup_image.png',
                        fit: BoxFit.fitWidth),
                  ),
                ),
                const Expanded(
                  child: RightPane(),
                ),
              ],
            ),
            const Copyright(mLeft: 45, mBot: 30),
          ],
        ),
      ),
    );
  }
}

class RightPane extends StatelessWidget {
  const RightPane({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 13.5, right: 13.5, bottom: 30),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Image.asset('assets/signup_ellipse_cropped.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 55.5, right: 55.5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 26.67,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Container(
                  width: 13.33,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Container(
                  width: 6.67,
                  margin: const EdgeInsets.only(right: 6),
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                const Expanded(
                  child: InputContainer(),
                ),
              ],
            ),
          ),
        ],
      ),
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
      padding: const EdgeInsets.only(left: 42, right: 42),
      decoration: const ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 4,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
      ),
      child: const Center(child: LoginPage()),
    );
  }
}

class AuthTitle extends StatelessWidget {
  final String title;

  const AuthTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -10),
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
    );
  }
}

class InputWidget extends StatelessWidget {
  final Color circleColor;
  final String labelText;
  final bool obscured;

  const InputWidget(
      {super.key, required this.circleColor, required this.labelText, required this.obscured});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: 17,
              height: 17,
              decoration: ShapeDecoration(
                color: circleColor,
                shape: const CircleBorder(),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: TextFormField(
              obscureText: obscured,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white
              ),
              maxLines: 1,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: const BorderSide(
                      color: Color(0xFF06BCC1),
                      width: 2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  contentPadding: const EdgeInsets.only(left: 20, right: 20),
                  hintText: labelText,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 144, 142, 142),
                      fontWeight: FontWeight.normal)),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckWidget extends StatelessWidget {
  final MainAxisAlignment alignment;
  final String text;

  const CheckWidget({
    super.key,
    required this.alignment,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 10),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFC2C2C2)),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: Checkbox(
            value: false,
            side: BorderSide.none,
            onChanged: (value) {},
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ],
    );
  }
}

    // return Container(
    //   padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: 12),
    //   decoration: ShapeDecoration(
    //     gradient: const LinearGradient(
    //       begin: Alignment(0, -1),
    //       end: Alignment(0, 1),
    //       colors: [
    //         Color(0xFF06BCC1),
    //         Color(0xFF047679),
    //       ],
    //     ),
    //     shape: RoundedRectangleBorder(
    //       side: const BorderSide(
    //         width: 4,
    //         strokeAlign: BorderSide.strokeAlignCenter,
    //         color: Color(0xFF06BCC1),
    //       ),
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //   ),
    // child: Text(
    //   text,
    //   textAlign: TextAlign.center,
    //   style: const TextStyle(
    //     color: Colors.white,
    //     fontSize: 20,
    //     fontFamily: 'DM Sans',
    //     fontWeight: FontWeight.w700,
    //     height: 0,
    //   ),
    // ),
    // );

