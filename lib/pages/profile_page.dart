import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/globals.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Stack(
        children: [
          const Text("Account Settings",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w700,
              height: 0,
            )
          ),
          AestheticBorder(
            borderColor: Colors.black,
            mainColor: const Color(0xFFF8F7F4),
            child: ProfileView(username: username, emailAddress: emailAddress,),
          ),
        ],
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  final String username;
  final String emailAddress;

  const ProfileView(
      {super.key, required this.username, required this.emailAddress});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 0.3*MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: Stack(
            children: [
              Container(
                height: 0.23*MediaQuery.of(context).size.height,
                color: Colors.amber,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {}, 
                    icon: const Icon(Icons.add_a_photo)),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder()
                  ),
                  onPressed: () {},
                  child: Container(
                    width: 0.16*MediaQuery.of(context).size.height,
                    height: 0.16*MediaQuery.of(context).size.height,
                    decoration: const ShapeDecoration(
                      color: Color(0xFF313638),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " University ID:",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color(0xFF06BCC1),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      widget.emailAddress.split('@')[0],
                      style: const TextStyle(
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
              SizedBox(height: 0.02*MediaQuery.of(context).size.height,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Name:",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color(0xFFD4515D),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      widget.username,
                      style: const TextStyle(
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
              SizedBox(height: 0.02*MediaQuery.of(context).size.height,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Email Address:",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFE66D),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      widget.emailAddress,
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
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 0.08*MediaQuery.of(context).size.height, bottom: 30),
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
              SizedBox(height: 0.025*MediaQuery.of(context).size.height,),
              Row(
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
                        SizedBox(height: 0.015*MediaQuery.of(context).size.height,),
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
                        SizedBox(height: 0.015*MediaQuery.of(context).size.height,),
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
            ],
          ),
        ),
      ],
    );
  }
}
