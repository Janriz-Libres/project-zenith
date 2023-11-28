import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 500, minHeight: 510,
        maxWidth: 550, maxHeight:  510
      ),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Expanded(
              flex: 4,
              child: AuthTitle(title: "SIGN UP")
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(left:0.02*MediaQuery.of(context).size.width, right: 0.02*MediaQuery.of(context).size.width),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputWidget(
                      circleColor: Color(0xFF06BCC1),
                      labelText: "Email Address",
                      obscured: false,
                      ),
                    InputWidget(
                      circleColor: Color(0xFFD4515D),
                      labelText: "Username",
                      obscured: false,
                      ),
                    InputWidget(
                      circleColor: Color(0xFFFFE66D),
                      labelText: "Password",
                      obscured: true,
                      ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 5,
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
                      function: () {},
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
