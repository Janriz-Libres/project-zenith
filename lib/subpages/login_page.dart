import 'package:firedart/auth/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/main.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/subpages/fresh_page.dart';
import 'package:project_zenith/subpages/profile_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';
import 'package:project_zenith/widgets/transparent_button.dart';
import 'package:project_zenith/widgets/authpage_textfield.dart';
import 'package:project_zenith/widgets/authpage_obscuredfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Function() function;

  const LoginPage({super.key, required this.function});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool valid = true;

  void validateForm() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.only(top: 12, left: 15),
              height: 50,
              decoration: const BoxDecoration(
                color: Color(0xFFC72C41),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Oh snap! Please enter your credentials.",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else if (!valid) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.only(top: 12, left: 15),
              height: 50,
              decoration: const BoxDecoration(
                  color: Color(0xFFC72C41),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Oh snap! Incorrect credentials.",
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'DM Sans',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );

        try {
          currentUser = await Authenticator.signIn(
            usernameController.text,
            passwordController.text,
          );

          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('email', currentUser!.email);
          await prefs.setString('pw', currentUser!.password);

          await initializeModels();

          if (context.mounted) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  emailAddress: currentUser!.email,
                  username: currentUser!.username,
                ),
              ),
            );
          }
        } on AuthException {
          // TODO
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: 500, minHeight: 510, maxWidth: 650, maxHeight: 510),
      child: Form(
        key: _formKey,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputWidget(
                      validator: (value) {
                        const pattern = r'\d{1,11}(@my.xu.edu.ph)';
                        final regex = RegExp(pattern);

                        if (value!.isNotEmpty && !regex.hasMatch(value)) {
                          setState(() {
                            valid = false;
                          });
                        } else {
                          setState(() {
                            valid = true;
                          });
                        }
                        return null;
                      },
                      controller: usernameController,
                      widget: Container(
                        width: 17,
                        height: 17,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFD4515D),
                          shape: CircleBorder(),
                        ),
                      ),
                      borderColor: Colors.white,
                      enabledColor: Colors.white,
                      focusedColor: const Color(0xFFD4515D),
                      obscured: false,
                      labelText: "Enter your email address",
                    ),
                    SizedBox(height: 0.02 * MediaQuery.of(context).size.height),
                    ObscuredField(
                      controller: passwordController,
                      widget: Container(
                        width: 17,
                        height: 17,
                        decoration: const ShapeDecoration(
                          color: Color(0xFFFFE66D),
                          shape: CircleBorder(),
                        ),
                      ),
                      labelText: "Enter your password",
                      borderColor: Colors.white,
                      enabledColor: Colors.white,
                      focusedColor: const Color(0xFFFFE66D),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
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
                              func: validateForm),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30, right: 30),
                            child: TransparentButton(
                              text: "Forgot Password",
                              hovered: const Color.fromARGB(255, 6, 140, 145),
                              flat: const Color(0xFF06BCC1),
                              lineColor: const Color.fromARGB(255, 6, 140, 145),
                              function: () {},
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
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 20,
                        left: 0.02 * MediaQuery.of(context).size.width,
                        right: 0.02 * MediaQuery.of(context).size.width),
                    child: Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 4, color: Color(0xFFD4515D)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
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
                              flat: const Color(0xFFD4515D),
                              hovered: const Color.fromARGB(255, 168, 40, 30),
                              lineColor: const Color(0xFFD4515D),
                              function: widget.function,
                            )
                          ],
                        )),
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
