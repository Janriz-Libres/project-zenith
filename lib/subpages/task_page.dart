import 'dart:ui';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/main.dart';
import 'package:project_zenith/subpages/createtasklist_dialog.dart';
import 'package:project_zenith/widgets/tasklist_card.dart';

class TaskPage extends StatefulWidget {
  final Workspace workspace;
  final List<WorkList> taskLists;
  final String label;

  const TaskPage(
      {super.key,
      required this.label,
      required this.workspace,
      required this.taskLists});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final tasklistNameController = TextEditingController();
  List<WorkList> displayLists = <WorkList>[];

  Future<void> updateTaskList() async {
    WorkList list = await widget.workspace.addList(tasklistNameController.text);

    setState(() {
      displayLists.add(list);
      lists.add(list);
    });
  }

  Future<void> deleteList(WorkList list) async {
    var reference = Firestore.instance.collection('lists').document(list.id);
    await reference.delete();

    setState(() {
      displayLists.remove(list);
      lists.remove(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (displayLists.isEmpty) {
      displayLists = widget.taskLists;
    }

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          Text(widget.label,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.w700,
                height: 0,
              )),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await showDialog(
                useSafeArea: false,
                context: context,
                builder: (context) {
                  return CreateTaskList(
                    tasklistNameController: tasklistNameController,
                    func: updateTaskList,
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
          constraints: const BoxConstraints(minWidth: 995, maxWidth: 1475),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // This next line does the trick.
                    children: displayLists.map((e) {
                      List<Task> thisTasks = <Task>[];

                      for (Task task in tasks) {
                        if (task.list.id == e.id) {
                          thisTasks.add(task);
                        }
                      }

                      return TaskList(
                        label: e.name,
                        list: e,
                        tasks: thisTasks,
                        deleteFunc: deleteList,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    ]);
  }
}
