import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/main.dart';
import 'package:project_zenith/pages/auth_page.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/widgets/submit_button.dart';
import 'package:project_zenith/widgets/authpage_textfield.dart';
import 'package:project_zenith/widgets/authpage_obscuredfield.dart';

class SignupPage extends StatefulWidget {
  final Function() function;

  const SignupPage({super.key, required this.function});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypeController = TextEditingController();

  bool validUsername = true;
  bool validEmailAddress = true;

  Future<void> validateForm() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.error_outline),
              ),
              Text('Oh snap! Sign up unsuccessful.'),
            ],
          ),
            action: SnackBarAction(
              label: 'Hide',
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );

    currentUser = await Authenticator.signUp(
      emailController.text,
      usernameController.text,
      passwordController.text,
    );

    await initializeModels();

    if (context.mounted) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage(
              emailAddress: currentUser!.email,
              username: currentUser!.username,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: BackButton(onPressed: widget.function),
      ),
      ConstrainedBox(
        constraints: const BoxConstraints(
            minWidth: 500, minHeight: 510, maxWidth: 650, maxHeight: 510),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(flex: 4, child: AuthTitle(title: "SIGN UP")),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 0.02 * MediaQuery.of(context).size.width,
                      right: 0.02 * MediaQuery.of(context).size.width),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InputWidget(
                        validator: (value) {
                          const pattern = r'\d{1,11}(@my.xu.edu.ph)';
                          final regex = RegExp(pattern);

                          if (!regex.hasMatch(value!)) {
                            setState(() => validEmailAddress = false);
                            return;
                          } else {
                            setState(() => validEmailAddress = true);
                            return null;
                          }
                        },
                        controller: emailController,
                        widget: Container(
                          width: 17,
                          height: 17,
                          decoration: const ShapeDecoration(
                            color: Color(0xFF06BCC1),
                            shape: CircleBorder(),
                          ),
                        ),
                        borderColor: Colors.white,
                        enabledColor: Colors.white,
                        focusedColor: const Color(0xFF06BCC1),
                        labelText: "Email Address",
                        obscured: false,
                      ),
                      InputWidget(
                        validator: (value) {
                          const pattern = r'\w+';
                          final regex = RegExp(pattern);

                          if (!regex.hasMatch(value!)) {
                            setState(() => validUsername = false);
                          } else {
                            setState(() => validUsername = true);
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
                        labelText: "Username",
                        obscured: false,
                      ),
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
                        labelText: "Password",
                        borderColor: Colors.white,
                        enabledColor: Colors.white,
                        focusedColor: const Color(0xFFFFE66D),
                      ),
                      ObscuredField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '';
                          } else {
                            return null;
                          }
                        },
                        controller: retypeController,
                        widget: Container(
                          width: 17,
                          height: 17,
                          decoration: const ShapeDecoration(
                            color: Colors.black87,
                            shape: CircleBorder(),
                          ),
                        ),
                        labelText: "Re-type Password",
                        borderColor: Colors.white,
                        enabledColor: Colors.white,
                        focusedColor: Colors.grey,
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
                          gradient: const [
                            Color(0xFF06BCC1),
                            Color(0xFF047679)
                          ],
                          minSize: const Size(300, 70),
                          func: () async => await validateForm(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
