import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_zenith/widgets/tasklist_card.dart';

class TaskPage extends StatelessWidget {
  final String label;
  
  const TaskPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return TaskView(label: label,);
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
              onPressed: () {},
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
                  height: 500,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // This next line does the trick.
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TaskList(label: "To Do")
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TaskList(label: "Doing")
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TaskList(label: "Done")
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TaskList(label: "Personal")
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TaskList(label: "Laag")
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: TaskList(label: "Others")
                        ), 
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