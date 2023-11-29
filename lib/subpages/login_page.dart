import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/main.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';
import 'package:project_zenith/widgets/transparent_button.dart';
import 'package:firedart/auth/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 42, right: 42),
      child: Form(
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
                padding: EdgeInsets.only(
                    left: 0.02 * MediaQuery.of(context).size.width,
                    right: 0.02 * MediaQuery.of(context).size.width),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InputWidget(
                      circleColor: const Color(0xFFD4515D),
                      labelText: "Enter your username",
                      controller: usernameController,
                    ),
                    InputWidget(
                      circleColor: const Color(0xFFFFE66D),
                      labelText: "Enter your password",
                      controller: passwordController,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 0.02 * MediaQuery.of(context).size.width,
                  right: 0.02 * MediaQuery.of(context).size.width,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SubmitButton(
                              text: "Log In",
                              gradient: const [
                                Color(0xFF06BCC1),
                                Color(0xFF047679)
                              ],
                              minSize: const Size(300, 70),
                              func: () async {
                                try {
                                  currentUser = await Authenticator.signIn(
                                    usernameController.text,
                                    passwordController.text,
                                  );

                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  await prefs.setString(
                                      'email', currentUser!.email);
                                  await prefs.setString(
                                      'pw', currentUser!.password);
                                } on AuthException {
                                  // TODO
                                }
                              }),
                        ),
                        const Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: TransparentButton(
                              text: "Forgot Password",
                              hovered: Color.fromARGB(255, 6, 140, 145),
                              flat: Color(0xFF06BCC1),
                              lineColor: Color.fromARGB(255, 6, 140, 145)),
                        )),
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
                        side: const BorderSide(
                            width: 4, color: Color(0xFFD4515D)),
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
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
