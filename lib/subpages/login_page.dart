import 'package:firedart/auth/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/subpages/loading_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Function() function;

  const LoginPage({super.key, required this.function});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool valid = true;

  void validateForm() async {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingPage();
        });

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    SnackBar snackbar = SnackBar(
      backgroundColor: Colors.red.shade800,
      content: const Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.error_outline,
              color: Colors.white,
            ),
          ),
          Text(
            'Oh snap! Log in unsuccessful.',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Hide',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    if (!formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
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
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green.shade400,
            content: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Log in successful.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            action: SnackBarAction(
              label: 'Hide',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ));
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
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: 500, minHeight: 510, maxWidth: 650, maxHeight: 510),
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
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputWidget(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '';
                        } else {
                          return null;
                        }
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return '';
                        } else {
                          return null;
                        }
                      },
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
    );
  }
}
