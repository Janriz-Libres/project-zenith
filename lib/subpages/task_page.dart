import 'package:flutter/material.dart';

class TaskPage extends StatelessWidget {
  final String label;
  
  const TaskPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return const TaskView(label: "",);
  }
}

class TaskView extends StatelessWidget {
  final String label;
  
  const TaskView({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: double.infinity,
          child: SelectableText(
            "Team Tasks",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              height: 0,
            )
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              color: Colors.amber,
              child: Row(
                children: [
                  
                ],
              ),
            ),
          ),
        )
      ]
    );
  }
}
