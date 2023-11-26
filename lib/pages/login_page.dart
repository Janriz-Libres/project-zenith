import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          flex: 5,
          child: AuthTitle(title: "LOG IN"),
        ),
        const Spacer(),
        const Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: InputWidget(circleColor: Color(0xFFD4515D))),
              Spacer(),
              Expanded(
                flex: 4,
                child: InputWidget(circleColor: Color(0xFFFFE66D))),
            ],
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: SubmitButton(
                      text: "Log In", 
                      hPadding: 10
                    )
                  ),
                  Expanded(
                    child: Text(
                      "Forgot Password?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF06BCC1),
                        fontSize: 18,
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: const Offset(0, 15),
                child: const CheckWidget(
                  alignment: MainAxisAlignment.start,
                  text: "Keep me signed in",
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: ShapeDecoration(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 4, color: Color(0xFFD4515D)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      TextSpan(
                        text: "Sign Up",
                        style: TextStyle(
                          color: Color(0xFFD4515D),
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
