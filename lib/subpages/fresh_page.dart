import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/main.dart';
import 'package:project_zenith/pages/home_page.dart';
import 'package:project_zenith/widgets/authpage_textfield.dart';
import 'package:project_zenith/widgets/submit_button.dart';
import 'package:firedart/firedart.dart';

class FreshPage extends StatelessWidget {
  FreshPage({super.key});

  final emailController = TextEditingController();
  final passController = TextEditingController();

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
                              func: () async {
                                await showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CheckInDialog(
                                      emailController: emailController,
                                      passController: passController,
                                    );
                                  },
                                );
                              },
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

class CheckInDialog extends StatelessWidget {
  const CheckInDialog({
    super.key,
    required this.emailController,
    required this.passController,
  });

  final TextEditingController emailController;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 14, color: Colors.white),
            controller: emailController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              hintText: "Enter your email address",
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 144, 142, 142),
                  fontWeight: FontWeight.normal),
            ),
          ),
          TextFormField(
            style: const TextStyle(fontSize: 14, color: Colors.white),
            controller: passController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: const BorderSide(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              contentPadding: const EdgeInsets.only(left: 20, right: 20),
              hintText: "Enter your password",
              hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 144, 142, 142),
                  fontWeight: FontWeight.normal),
            ),
          ),
          SubmitButton(
            text: "Submit",
            gradient: const [Color(0xFF06BCC1), Color(0xFF168285)],
            minSize: const Size(200, 50),
            func: () async {
              List<Document> docs = await Firestore.instance
                  .collection('users')
                  .where('email', isEqualTo: emailController.text)
                  .where('password', isEqualTo: passController.text)
                  .get();

              if (docs.isEmpty && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("OI that is wrong.")),
                );
                return;
              }

              Document thisUser = docs.first;
              await thisUser.reference.update({
                'time_started': DateTime.now(),
                'has_checked_in': true,
              });

              checkedInUsers.add(User(
                authId: thisUser['auth_id'],
                email: thisUser['email'],
                id: thisUser['id'],
                password: thisUser['password'],
                username: thisUser['username'],
                timeStarted: thisUser['time_started'],
                hasCheckedIn: thisUser['has_checked_in'],
              ));

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Nice ka wan pipty.")),
                );

                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
