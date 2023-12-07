import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/globals.dart';

class ProfilePage extends StatelessWidget {
  final Function(String name) func;
  const ProfilePage({super.key, required this.func});

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
            child: ProfileView(func: func,),
          ),
        ],
      ),
    );
  }
}

class ProfileView extends StatefulWidget {
  final Function(String name) func;
  const ProfileView(
      {super.key, required this.func});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final newName = TextEditingController();
  bool editable = false;
  bool disabled = true;
  bool editName = false;
  bool editBg = false;
  Color color = Colors.grey;

  @override
  void dispose() {
    newName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 0.3*MediaQuery.of(context).size.height,
          width: double.maxFinite,
          child: Stack(
            children: [
              MouseRegion(
                onEnter: (event) => setState(() {
                  editBg = true;
                }),
                onExit: (event) => setState(() {
                  editBg = false;
                }),
                child: Container(
                  height: 0.23*MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                    ),
                    color: Color.fromARGB(255, 152, 147, 147),
                  ),
                  child: AnimatedOpacity(
                    opacity: editBg ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        onPressed: () {}, 
                        icon: const Icon(Icons.add_a_photo)),
                    ),
                  ),
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
          padding: const EdgeInsets.only(left: 50, right: 50, top: 30),
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
                      gUser!.email.split('@')[0],
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
                  MouseRegion(
                    onEnter: (event) => setState(() {
                      editName = true;
                    }),
                    onExit: (event) => setState(() {
                      editName = false;
                    }),
                    child: Container(
                      width: double.maxFinite,
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD4515D),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      child: !editable ? Row(
                        children: [
                          Text(
                            gUser!.username.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          const Spacer(),
                          AnimatedOpacity(
                            opacity: editName ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  editable = true;
                                });
                              }, 
                              icon: const Icon(Icons.edit, color: Colors.white,)),
                          )
                        ],
                      ) : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: newName,
                              decoration: InputDecoration(
                                hintText: gUser!.username.toUpperCase()
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500
                              ),
                              onChanged: (text) {
                                if (text == gUser!.username || text.isEmpty) {
                                  setState(() {
                                    disabled = true;
                                    color = Colors.grey;
                                  });
                                } else {
                                  setState(() {
                                    disabled = false;
                                    color = Colors.white;
                                  });
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              newName.clear();
                              setState(() {
                                editable = false;
                                disabled = true;
                                editName = false;
                                color = Colors.grey;
                              });
                            }, 
                            icon: const Icon(Icons.close, color: Colors.white)),
                          IconButton(
                            onPressed: disabled ? null : 
                            () async {
                              gUser = await gUser?.updateUsername(newName.text);
                              widget.func(newName.text);
                              newName.clear();
                              setState(() {
                                editable = false;
                                disabled = true;
                                editName = false;
                                color = Colors.grey;
                              });
                            }, 
                            icon: Icon(Icons.subdirectory_arrow_left, color: color)
                          )
                        ],
                      )
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
                      gUser!.email,
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
