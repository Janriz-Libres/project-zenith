import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';


class SignupPage extends StatelessWidget {
  const SignupPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          flex: 5,
          child: AuthTitle(
            title: "SIGN UP"
            )
          ),
        const Expanded(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 4,
                child: InputWidget(circleColor: Color(0xFF06BCC1))),
              Spacer(),
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
          flex: 4,
          child: Column(
            children: [
              const CheckWidget(
                alignment: MainAxisAlignment.center,
                text: "I've read and agree to\nTerms & Conditions",
              ),
              Transform.translate(
                offset: const Offset(0, 10),
                child: const SizedBox(
                  child: SubmitButton(
                    text: "Create Account", 
                    gradient: [Color(0xFF06BCC1), Color(0xFF047679)],
                    function: test
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(flex: 2)
      ],
    );
  }
}

void test() {

}