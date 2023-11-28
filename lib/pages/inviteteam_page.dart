import 'package:flutter/material.dart';
import 'package:project_zenith/widgets/copyright_mark.dart';
import 'package:project_zenith/widgets/submit_button.dart';
import 'package:project_zenith/widgets/transparent_button.dart';

class InviteTeamPage extends StatelessWidget {
  const InviteTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image.asset("assets/left_bg.png"),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset("assets/right_bg.png"),
          ),
          const Padding(
            padding:
                EdgeInsets.only(top: 18, bottom: 80, left: 120, right: 120),
            child: Content(),
          ),
          const Copyright(mLeft: 85, mBot: 30),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackButton(onPressed: () {
          Navigator.pop(context);
        }),
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
            padding: const EdgeInsets.only(top: 65, bottom: 65),
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
                                  'Invite Your Team!',
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 0.25 * MediaQuery.of(context).size.width,
                          right: 0.25 * MediaQuery.of(context).size.width),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 7,
                              child:
                                  WorkspaceField(label: "Workspace Members:"),
                            ),
                            Spacer(),
                            Expanded(
                              flex: 6,
                              child: LongInputField(
                                  label: "Or invite them with one code:"),
                            ),
                            Spacer(flex: 2),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(children: [
                                      Expanded(
                                          child: SubmitButton(
                                              text: "Invite Members",
                                              gradient: [
                                                Color(0xFF06BCC1),
                                                Color(0xFF047679)
                                              ],
                                              minSize: Size(300, 70),
                                              function: test)),
                                      Expanded(
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: TransparentButton(
                                          text: "I'll do this later",
                                          hovered:
                                              Color.fromARGB(255, 6, 140, 145),
                                          flat: Color(0xFF06BCC1),
                                          lineColor:
                                              Color.fromARGB(255, 6, 140, 145),
                                        ),
                                      ))
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    )),
                const Spacer(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset("assets/signup_ellipse.png"),
        )
      ],
    );
  }
}

class WorkspaceField extends StatelessWidget {
  final String label;

  const WorkspaceField({super.key, required this.label});

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
          child: Container(
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 13, bottom: 13, left: 5, right: 0),
                          decoration: const ShapeDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/signup_ellipse.png")),
                            shape: OvalBorder(),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                width: 4,
                                color: Color(0xFFFFE66D),
                              ),
                              borderRadius: BorderRadius.circular(50),
                            ),
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
      ],
    );
  }
}

class LongInputField extends StatelessWidget {
  final String label;

  const LongInputField({super.key, required this.label});

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
                  color: Colors.white,
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
          flex: 7,
          child: Container(
              height: 51,
              decoration: ShapeDecoration(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 4,
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5)),
              )),
        )
      ],
    );
  }
}

void test() {}
