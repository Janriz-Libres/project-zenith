import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(flex: 5, child: AuthTitle(title: "SIGN UP")),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InputWidget(
                    circleColor: const Color(0xFF06BCC1),
                    labelText: "Email Address",
                    controller: TextEditingController(),
                  ),
                  InputWidget(
                    circleColor: const Color(0xFFD4515D),
                    labelText: "Username",
                    controller: TextEditingController(),
                  ),
                  InputWidget(
                    circleColor: const Color(0xFFFFE66D),
                    labelText: "Password",
                    controller: TextEditingController(),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const CheckWidget(
                    alignment: MainAxisAlignment.center,
                    text: "I've read and agree to\nTerms & Conditions",
                  ),
                  Transform.translate(
                    offset: const Offset(0, 10),
                    child: SizedBox(
                      child: SubmitButton(
                        text: "Create Account",
                        gradient: const [Color(0xFF06BCC1), Color(0xFF047679)],
                        minSize: const Size(300, 70),
                        func: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 2)
          ],
        ),
      ),
    );
  }
}
