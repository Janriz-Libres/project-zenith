import 'dart:async';

import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';

Map<User, Duration> checkedInUsers = <User, Duration>{};

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

    return GridView.builder(
      itemCount: checkedInUsers.length,
      itemBuilder: (context, index) {
        User user = checkedInUsers.keys.elementAt(index);

        return Card(
          color: Colors.yellowAccent,
          child: Column(
            children: [
              Text(user.email),
              Text(checkedInUsers[user].toString().substring(0, 7)),
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
                  },
                  child: const Text("Check Out"))
            ],
          ),
        );
      },
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
    );
  }
}
