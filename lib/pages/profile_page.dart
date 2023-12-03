import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/globals.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      widthFactor: 0.6,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: AestheticBorder(
          borderColor: Colors.black,
          mainColor: const Color(0xFFF8F7F4),
          child: ProfileView(
            username: currentUser!.username,
            emailAddress: currentUser!.email,
          ),
        ),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final String username;
  final String emailAddress;

  const ProfileView(
      {super.key, required this.username, required this.emailAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(38),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 264.5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Align(
                          alignment: Alignment.center,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              decoration: const ShapeDecoration(
                                color: Color(0xFF313638),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 12,
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            color: Color(0xFF06BCC1),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          child: SelectableText(
                            emailAddress.split('@')[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0.02 * MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD4515D),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: SelectableText(
                        username,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02 * MediaQuery.of(context).size.height,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFE66D),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: SelectableText(
                        emailAddress,
                        style: const TextStyle(
                          color: Color(0xFF646869),
                          fontSize: 15,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 0.08 * MediaQuery.of(context).size.height),
              child: Column(
                children: [
                  const Text(
                    "Attendance Reflected",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF313638),
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 0.025 * MediaQuery.of(context).size.height,
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Time Started:",
                                style: TextStyle(
                                  color: Color(0xFF313638),
                                  fontSize: 15,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              SizedBox(
                                height:
                                    0.015 * MediaQuery.of(context).size.height,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 13),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: const Text(
                                  '00:00 AM',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Today's Duty Hours:",
                                style: TextStyle(
                                  color: Color(0xFF313638),
                                  fontSize: 15,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                ),
                              ),
                              SizedBox(
                                height:
                                    0.015 * MediaQuery.of(context).size.height,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 13),
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                child: const Text(
                                  '00:00:00',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
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
        ],
      ),
    );
  }
}
