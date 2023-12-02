import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/pages/buildworkspace_page.dart';
import 'package:project_zenith/pages/joinworkspace_page.dart';
import 'package:project_zenith/pages/landing_page.dart';

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
                              )),
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
                          )))
                        ],
                      ),
                    )),
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
                                  Color(0xFF168285)
                                ],
                                minSize: const Size(300, 70),
                                func: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BuildWorkspacePage()))
                                    }),
                          )
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
                                  Color(0xFFB12935)
                                ],
                                minSize: const Size(300, 70),
                                func: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const JoinWorkspacePage()))
                                    }),
                          )
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
                                    builder: (context) => const LandingPage(),
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

/*
class WelcomeButton extends StatelessWidget {
  final String imgPath;
  final String text;
  final List<Color> btnColors;

  const WelcomeButton({
    super.key,
    required this.imgPath,
    required this.text,
    required this.btnColors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        Container(
          width: 364,
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: const Alignment(0, -1),
              end: const Alignment(0, 1),
              colors: btnColors,
            ),
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 4, color: btnColors.first),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'DM Sans',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
        ),
      ],
    );
  }
}
*/
