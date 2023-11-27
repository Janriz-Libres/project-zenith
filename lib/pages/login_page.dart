import 'package:flutter/material.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';
import 'package:project_zenith/widgets/transparent_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(
            flex: 5,
            child: AuthTitle(title: "LOG IN"),
          ),
          const Spacer(),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(left:0.02*MediaQuery.of(context).size.width, right: 0.02*MediaQuery.of(context).size.width),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InputWidget(
                    circleColor: Color(0xFFD4515D),
                    labelText: "Enter your username",
                    ),
                  InputWidget(
                    circleColor: Color(0xFFFFE66D),
                    labelText: "Enter your password",
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.only(left:0.02*MediaQuery.of(context).size.width, right: 0.02*MediaQuery.of(context).size.width),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: SubmitButton(
                          text: "Log In",
                          gradient: [Color(0xFF06BCC1), Color(0xFF047679)],
                          function: test
                        )
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: TransparentButton(
                            text: "Forgot Password",
                            hovered: Color.fromARGB(255, 6, 140, 145),
                            flat: Color(0xFF06BCC1),
                            lineColor: Color.fromARGB(255, 6, 140, 145)
                          ),
                        )
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      TransparentButton(
                        text: "Sign Up", 
                        flat: Color(0xFFD4515D), 
                        hovered: Color.fromARGB(255, 168, 40, 30), 
                        lineColor: Color(0xFFD4515D),
                      )
                    ],
                  )
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void test() {

}