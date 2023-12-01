import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/main.dart';

class TaskList extends StatefulWidget {
  final String label;
  final WorkList list;
  final List<Task> tasks;
  final Function(WorkList list) deleteFunc;

  const TaskList({
    super.key,
    required this.label,
    required this.list,
    required this.tasks,
    required this.deleteFunc,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task> displayTasks = <Task>[];

  final titleController = TextEditingController();
  final descController = TextEditingController();

  Future<void> updateTasks() async {
    Task task =
        await widget.list.addTask(titleController.text, descController.text);

    setState(() {
      displayTasks.add(task);
      tasks.add(task);
    });
  }

  Future<void> deleteTasks() async {
    for (Task task in displayTasks) {
      var reference = Firestore.instance.collection('tasks').document(task.id);
      reference.delete();
    }

    setState(() {
      tasks.removeWhere((element) => displayTasks.contains(element));
      displayTasks.clear();
    });
  }

  void deleteSingleTask(Task task) {
    setState(() {
      displayTasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (displayTasks.isEmpty) {
      displayTasks = widget.tasks;
    }

    return DragTarget<TaskFuncPair>(
      onWillAccept: (data) => !displayTasks.contains(data?.task),
      onAccept: (data) async {
        setState(() {
          displayTasks.add(data.task);
        });

        await data.func(data.task);

        var reference =
            Firestore.instance.collection('tasks').document(data.task.id);
        await reference.update({
          'list':
              Firestore.instance.collection('lists').document(widget.list.id),
        });

        tasks.clear();
        for (WorkList list in lists) {
          tasks.addAll(await list.getTasks());
        }
      },
      builder: (context, incoming, rejected) {
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SizedBox(
            width: 321,
            child: Card(
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                //set border radius more than 50% of height and width to make circle
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.label.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () async {
                              await deleteTasks();
                              await widget.deleteFunc(widget.list);
                            },
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: displayTasks
                              .map(
                                (e) => Draggable<TaskFuncPair>(
                                  data: TaskFuncPair(
                                    task: e,
                                    func: deleteSingleTask,
                                  ),
                                  feedback: Card(
                                    child: Text(e.title),
                                  ),
                                  childWhenDragging: Container(),
                                  child: Card(
                                    child: Text(e.title),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.add),
                            Text(
                              "Add a card",
                              style:
                                  TextStyle(fontFamily: "Rubik", fontSize: 16),
                            )
                          ],
                        ),
                        onPressed: () async {
                          await showDialog(
                            useSafeArea: false,
                            context: context,
                            builder: (context) {
                              return Scaffold(
                                backgroundColor: Colors.transparent,
                                body: AlertDialog(
                                  content: Column(
                                    children: [
                                      TextFormField(
                                          controller: titleController),
                                      TextFormField(controller: descController),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await updateTasks();

                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: const Text("Enter"),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TaskFuncPair {
  final Task task;
  final Function(Task) func;

  const TaskFuncPair({
    required this.task,
    required this.func,
  });
}
