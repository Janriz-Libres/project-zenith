import 'package:firedart/auth/exceptions.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/pages/loading_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLogin = true;

  void _switchAuthPage() {
    setState(() => _isLogin = !_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.all(25),
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 3,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: Colors.white,
            ),
          ),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 70, right: 80, top: 13.5, bottom: 13.5),
                    child: Image.asset(
                      'assets/signup_image.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 13.5, right: 13.5, bottom: 30),
                    child: AestheticBorder(
                      borderColor: Colors.white,
                      mainColor: Colors.black,
                      child: Center(
                        child: _isLogin
                            ? LoginPage(switchFunc: _switchAuthPage)
                            : SignupPage(switchFunc: _switchAuthPage),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Copyright(mLeft: 45, mBot: 30),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  final Function() switchFunc;

  const SignupPage({
    super.key,
    required this.switchFunc,
  });

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final retypeController = TextEditingController();

  Future<void> _validateForm() async {
    try {
      _validateEmail();
      _validateUser();
      _validatePassword();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      currentUser = await Authenticator.signUp(
        emailController.text,
        usernameController.text,
        passwordController.text,
      );

      await initWorkspaceModels();

      if (context.mounted) {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ),
        );
      }
    } on Exception {
      if (context.mounted) {
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
      }
    }
  }

  void _validateEmail() {
    const pattern = r'\d{1,11}(@my.xu.edu.ph)';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(emailController.text)) {
      throw Exception();
    }
  }

  void _validateUser() {
    const pattern = r'\w+';
    final regex = RegExp(pattern);

    if (!regex.hasMatch(usernameController.text)) {
      throw Exception();
    }
  }

  void _validatePassword() {
    if (passwordController.text.isEmpty ||
        passwordController.text != retypeController.text &&
            passwordController.text.isNotEmpty) {
      throw Exception();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    retypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
              minWidth: 500, minHeight: 510, maxWidth: 650, maxHeight: 510),
          child: Form(
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
                            func: () async => await _validateForm(),
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
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15),
          child: ElevatedButton(
              onPressed: widget.switchFunc,
              child: const Icon(Icons.arrow_back)),
        ),
      ],
    );
  }
}

class LoginPage extends StatefulWidget {
  final Function() switchFunc;

  const LoginPage({
    super.key,
    required this.switchFunc,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _validateForm() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoadingPage()),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    try {
      currentUser = await Authenticator.signIn(
        usernameController.text,
        passwordController.text,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('email', currentUser!.email);
      await prefs.setString('pw', currentUser!.password);

      await initWorkspaceModels();

      if (context.mounted) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
                if (context.mounted) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
              },
            ),
          ),
        );
      }
    } on AuthException {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InputWidget(
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
                            func: _validateForm),
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
                            function: widget.switchFunc,
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

class CheckWidget extends StatelessWidget {
  final MainAxisAlignment alignment;
  final String text;

  const CheckWidget({
    super.key,
    required this.alignment,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 20,
          height: 20,
          margin: const EdgeInsets.only(right: 10),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFFC2C2C2)),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: const Checkbox(
            value: false,
            side: BorderSide.none,
            onChanged: null,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ],
    );
  }
}

class AuthTitle extends StatelessWidget {
  final String title;

  const AuthTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 60,
            fontFamily: 'Work Sans',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
        Transform.translate(
          offset: const Offset(0, -10),
          child: const Text(
            "Crusader Yearbook",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }
}
