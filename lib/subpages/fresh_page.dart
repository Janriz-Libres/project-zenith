import 'package:flutter/material.dart';
import 'package:project_zenith/widgets/submit_button.dart';

class FreshPage extends StatelessWidget {
  const FreshPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.5,
      widthFactor: 0.52,
      child: Align(
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Column(
            children: [
              Expanded(
                flex: 8,
                child: Image.asset("assets/signup_ellipse_cropped.png"),
              ),
              const Spacer(),
              const Text(
                'Welcome to Zenith!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF313638),
                  fontSize: 40,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              const Spacer(flex: 3),
              Expanded(
                flex: 4,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: SubmitButton(
                              text: "Check In",
                              gradient: const [
                                Color(0xFF06BCC1),
                                Color(0xFF168285)
                              ],
                              minSize: const Size(200, 50),
                              function: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Expanded(
                            child: SubmitButton(
                              text: "Check Out",
                              gradient: const [
                                Color(0xFF06BCC1),
                                Color(0xFF168285)
                              ],
                              minSize: const Size(200, 50),
                              function: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
