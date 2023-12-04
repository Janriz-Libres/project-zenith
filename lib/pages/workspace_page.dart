import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';
import 'package:project_zenith/pages/members_page.dart';

class WorkspacePage extends StatefulWidget {
  final Workspace workspace;

  const WorkspacePage({
    super.key,
    required this.workspace,
  });

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

enum ContentWidget { task, members }

class _WorkspacePageState extends State<WorkspacePage> {
  ContentWidget contentWidget = ContentWidget.task;

  final boardNameController = TextEditingController();
  final tasklistNameController = TextEditingController();

  void _changeContent(ContentWidget cw) {
    setState(() {
      contentWidget = cw;
    });
  }

  @override
  void dispose() {
    boardNameController.dispose();
    tasklistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: Row(
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 330, maxWidth: 385),
              child: Container(
                padding: const EdgeInsets.only(top: 25),
                decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(2, 0),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 29),
                      child: Row(
                        children: [
                          Container(
                            width: 35,
                            height: 35,
                            decoration: const ShapeDecoration(
                              color: Color(0xFF313638),
                              shape: OvalBorder(),
                            ),
                          ),
                          const Spacer(),
                          const Expanded(
                            flex: 18,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Production Department",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                                Text(
                                  "In charge of operations",
                                  style: TextStyle(
                                    color: Color(0xFF636769),
                                    fontSize: 15,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SidebarList(children: [
                      DrawOption(
                        imgPath: "assets/white_logo.png",
                        text: "Workspace",
                        func: () {
                          _changeContent(ContentWidget.task);
                        },
                      ),
                      DrawOption(
                        imgPath: "assets/build_icon.png",
                        text: "Members",
                        func: () => _changeContent(ContentWidget.members),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 24),
                              child: Row(children: [
                                const Text(
                                  'BOARDS',
                                  style: TextStyle(
                                    color: Color(0xFF959A9C),
                                    fontSize: 16,
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () async {
                                    await showDialog(
                                      useSafeArea: false,
                                      context: context,
                                      builder: (context) {
                                        return CreateBoardDialog(
                                          boardNameController:
                                              boardNameController,
                                          tasklistNameController:
                                              tasklistNameController,
                                        );
                                      },
                                    );
                                  },
                                )
                              ]),
                            ),
                            Flexible(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minHeight: 375, maxHeight: 750),
                                child: SingleChildScrollView(
                                  child: SidebarList(children: [
                                    DrawOption(
                                      imgPath: "assets/join_icon.png",
                                      text: "Booth Department",
                                      func: () {},
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 21),
                  child: BackButton(onPressed: () {
                    Navigator.pop(context);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 70, bottom: 30),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      switch (contentWidget) {
                        case ContentWidget.task:
                          return TaskPage(
                            workspace: widget.workspace,
                          );
                        case ContentWidget.members:
                          return MembersPage(space: widget.workspace);
                        default:
                          throw Exception();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskPage extends StatefulWidget {
  final Workspace workspace;

  const TaskPage({
    super.key,
    required this.workspace,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final tasklistNameController = TextEditingController();
  List<WorkList>? worklists;

  void initWorklists() {
    if (worklists != null) {
      return;
    }

    worklists = <WorkList>[];

    for (WorkList list in gLists) {
      if (list.workspace == widget.workspace) {
        worklists?.add(list);
      }
    }
  }

  @override
  void dispose() {
    tasklistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initWorklists();

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        children: [
          const SelectableText("Team Tasks",
              textAlign: TextAlign.left,
              style: TextStyle(
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
                  return CreateTaskListDialog(
                    tasklistNameController: tasklistNameController,
                    func: () {},
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
                    children: worklists!.map((e) => TaskList(list: e)).toList(),
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

class TaskList extends StatefulWidget {
  final WorkList list;

  const TaskList({
    super.key,
    required this.list,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task>? tasks;
  final titleController = TextEditingController();
  final descController = TextEditingController();

  Future<void> _addTask() async {
    Task newTask =
        await widget.list.addTask(titleController.text, titleController.text);
    gTasks.add(newTask);

    setState(() {
      tasks = null;
    });

    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _removeTask(Task task) async {
    setState(() {
      tasks?.remove(task);
    });
    await widget.list.deleteTask(task);
  }

  Future<void> _moveTask(TaskFuncPair data) async {
    setState(() {
      tasks?.add(data.task);
    });

    await data.removeTaskFunc(data.task);
    await data.task.changeParentList(widget.list);
  }

  void initTasks() {
    if (tasks != null) {
      return;
    }

    tasks = <Task>[];

    for (Task task in gTasks) {
      if (task.list.id == widget.list.id) {
        tasks?.add(task);
      }
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initTasks();

    return DragTarget<TaskFuncPair>(
      onWillAccept: (data) => !(tasks!.contains(data?.task)),
      onAccept: (data) async {
        await _moveTask(data);
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
                            widget.list.name.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_horiz),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    const Divider(),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: tasks!
                              .map(
                                (e) => Draggable<TaskFuncPair>(
                                  data: TaskFuncPair(
                                    task: e,
                                    removeTaskFunc: _removeTask,
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
                                        onPressed: _addTask,
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
  final Function(Task) removeTaskFunc;

  const TaskFuncPair({
    required this.task,
    required this.removeTaskFunc,
  });
}
