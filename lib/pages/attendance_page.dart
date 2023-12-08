import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';

Map<User, Duration> checkedInUsers = <User, Duration>{};
Map<User, Attendance> userAttendance = <User, Attendance>{};

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Timer? timer;

  void updateElapsedTime() {
    setState(() {
      for (User key in checkedInUsers.keys) {
        checkedInUsers[key] = checkedInUsers[key]! + const Duration(seconds: 1);
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(const Duration(seconds: 1), (timer) {
      updateElapsedTime();
    });

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Duty Hours",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
                height: 0,
              )),
          const Divider(),
          Flexible(
            child: ListView.builder(
              itemCount: checkedInUsers.length,
              itemBuilder: (context, index) {
                User user = checkedInUsers.keys.elementAt(index);

                return SizedBox(
                  height: 75,
                  child: Card(
                    color: const Color(0xFF06BCC1),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: const ShapeDecoration(
                                  color: Color(0xFF313638),
                                  shape: OvalBorder(),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    user.username,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  Text(
                                    user.email,
                                    style: const TextStyle(
                                      color: Color(0xFF636769),
                                      fontSize: 15,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(checkedInUsers[user].toString().substring(0, 7)),
                          const SizedBox(width: 50),
                          ElevatedButton(
                              onPressed: () async {
                                DocumentReference userRef = Firestore.instance
                                    .collection('users')
                                    .document(user.id);

                                Document userDoc = await userRef.get();
                                int totalMins = await userDoc['total_minutes'];
                                totalMins += checkedInUsers[user]!.inMinutes;

                                await userRef.update({
                                  'has_checked_in': false,
                                  'total_minutes': totalMins,
                                });

                                setState(() {
                                  checkedInUsers.remove(user);
                                });

                                await userAttendance[user]!.checkout(DateTime.now().toUtc());

                                setState(() {
                                  userAttendance.remove(user);
                                });

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
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
                                          'Checked out successfully.',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    action: SnackBarAction(
                                      label: 'Hide',
                                      textColor: Colors.white,
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .hideCurrentSnackBar();
                                      },
                                    ),
                                  ));
                                }
                              },
                              child: const Text("Check Out"))
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
