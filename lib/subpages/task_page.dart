import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_zenith/subpages/createtasklist_dialog.dart';
import 'package:project_zenith/widgets/tasklist_card.dart';

class TaskPage extends StatefulWidget {
  final String label;

  const TaskPage({super.key, required this.label});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final tasklistNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
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
              onPressed: () async {
                await showDialog(
                  useSafeArea: false,
                  context: context,
                  builder: (context) {
                    return CreateTaskList(
                      tasklistNameController: tasklistNameController,
                    );
                  },
                );
              },
            )
          ],
        ),
        const Divider(),
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
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskList(label: "To Do"),
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