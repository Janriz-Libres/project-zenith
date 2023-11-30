import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_zenith/widgets/tasklist_card.dart';

class TaskPage extends StatelessWidget {
  final String label;
  
  const TaskPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            SelectableText(
              label,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
                height: 0,
              )
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {Navigator.pop(context);},
            )
          ],
        ),
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 995, maxWidth: 1475
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                }),
                child: const SizedBox(
                  height: double.maxFinite,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // This next line does the trick.
                      children: [
                        TaskList(label: "To Do"),
                        TaskList(label: "Doing"),
                        TaskList(label: "Done"),
                        TaskList(label: "Personal"),
                        TaskList(label: "Laag"),
                        TaskList(label: "Others"), 
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ]
    );
  }
}