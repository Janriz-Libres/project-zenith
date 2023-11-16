import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Column(
          children: [
            ListTile(
              title: Text('Zenith'),
              subtitle: Text('dummy_email@gmail.com'),
              leading: Icon(Icons.circle),
            ),
            ListTile(
              title: Text('Home'),
              leading: Icon(Icons.home),
            ),
            ListTile(
              title: Text('Profile'),
              leading: Icon(Icons.person),
            ),
            ListTile(
              title: Text('Notifications'),
              leading: Icon(Icons.notifications),
            ),
            ListTile(
              title: Text('Attendance'),
              leading: Icon(Icons.recent_actors),
            ),
            ListTile(
              title: Text('Settings'),
              leading: Icon(Icons.settings),
            ),
          ],
        ),
      ],
    );
  }
}
