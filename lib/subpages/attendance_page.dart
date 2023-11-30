import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/pages/home_page.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<User> users = checkedInUsers;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: checkedInUsers.length,
      itemBuilder: (context, index) {
        User user = checkedInUsers[index];

        return Card(
          color: Colors.yellowAccent,
          child: Column(
            children: [
              Text(user.email),
              ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      checkedInUsers.remove(user);
                      users = checkedInUsers;
                    });

                    DocumentReference userRef = Firestore.instance
                        .collection('users')
                        .document(user.id);

                    await userRef.update({
                      'has_checked_in': false,
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
