import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/prompt_pages/joinworkspace_page.dart';
import 'package:project_zenith/prompt_pages/buildworkspace_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 62),
          decoration: const ShapeDecoration(
            color: Colors.black,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 3,
                strokeAlign: BorderSide.strokeAlignCenter,
                color: Colors.white,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 65),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 100, right: 100),
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 3,
                          child: FittedBox(
                            child: Text(
                              'Welcome to Zenith',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                                fontFamily: 'Work Sans',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            child: Transform.translate(
                              offset: const Offset(0, -5),
                              child: const Text(
                                'Crusader Yearbook',
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/build_icon.png",
                            width: 60,
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SubmitButton(
                              text: "Build a Workspace?",
                              gradient: const [
                                Color(0xFF06BCC1),
                                Color(0xFF168285),
                              ],
                              minSize: const Size(300, 70),
                              func: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const BuildWorkspacePage(),
                                  ),
                                ),
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/join_icon.png",
                            width: 60,
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SubmitButton(
                              text: "Join a Workspace?",
                              gradient: const [
                                Color(0xFFD4515D),
                                Color(0xFFB12935),
                              ],
                              minSize: const Size(300, 70),
                              func: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const JoinWorkspacePage(),
                                  ),
                                )
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/later_icon.png",
                            width: 60,
                            height: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: SubmitButton(
                              text: "I'll do this later",
                              gradient: const [
                                Color(0xFFFFE66D),
                                Color(0xFF927E1D)
                              ],
                              minSize: const Size(300, 70),
                              func: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                )
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/white_logo.png"),
        ),
      ],
    );
  }
}

class WorkspaceField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const WorkspaceField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            child: FittedBox(
              child: Text(
                label,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFFFFE66D),
                  fontSize: 30,
                  fontFamily: 'DM Sans',
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              InputWidget(
                // validator: (value) {
                //   const pattern =
                //       r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                //       r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                //       r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                //       r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                //       r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                //       r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                //       r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                //   final regex = RegExp(pattern);

                //   return value!.isNotEmpty && !regex.hasMatch(value)
                //       ? 'Enter a valid email address'
                //       : null;
                // },
                controller: controller,
                labelText: "Enter workspace name",
                obscured: true,
                widget: Container(
                  width: 17,
                  height: 17,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/signup_ellipse.png")),
                    shape: OvalBorder(),
                  ),
                ),
                borderColor: const Color(0xFFFFE66D),
                enabledColor: const Color(0xFFFFE66D),
                focusedColor: const Color(0xFF06BCC1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
