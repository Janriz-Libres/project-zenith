import 'package:flutter/material.dart';
import 'package:project_zenith/globals.dart';

class RenderTimePage extends StatelessWidget {
  const RenderTimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gAllUsers
          .map((e) => Row(children: [
                Text(e.email.toString()),
                Text(e.totalMinutes.toString()),
              ]))
          .toList(),
    );
  }
}
