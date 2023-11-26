import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(child: AuthTitle(title: "SIGN UP")),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InputWidget(circleColor: Color(0xFF06BCC1)),
              InputWidget(circleColor: Color(0xFFD4515D)),
              InputWidget(circleColor: Color(0xFFFFE66D)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckWidget(
                alignment: MainAxisAlignment.center,
                text: "I've read and agree to\nTerms & Conditions",
              ),
              SubmitButton(text: "Create Account", hPadding: 30),
            ],
          ),
        ),
      ],
    );
  }
}
