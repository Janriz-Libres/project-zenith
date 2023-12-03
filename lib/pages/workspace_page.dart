import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
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

class _WorkspacePageState extends State<WorkspacePage> {
  bool showTask = true;
  bool showMembers = false;
  final boardNameController = TextEditingController();
  final tasklistNameController = TextEditingController();

  void _showTask() {
    setState(() {
      showTask = true;
      showMembers = false;
    });
  }

  void _showMembers() {
    setState(() {
      showTask = false;
      showMembers = true;
    });
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
                          _showTask();
                        },
                      ),
                      DrawOption(
                        imgPath: "assets/build_icon.png",
                        text: "Members",
                        func: () {
                          _showMembers();
                        },
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
                  child: LayoutBuilder(builder: (context, constraints) {
                    List<WorkList> listArg = <WorkList>[];

                    if (showTask) {
                      // for (WorkList list in lists) {
                      //   if (list.workspace == widget.workspace) {
                      //     listArg.add(list);
                      //   }
                      // }

                      return TaskPage(
                        label: "Team Tasks",
                        workspace: widget.workspace,
                        taskLists: listArg,
                      );
                    } else if (showMembers) {
                      return MembersPage(space: widget.workspace);
                    } else {
                      // for (WorkList list in lists) {
                      //   if (list.workspace == widget.workspace) {
                      //     listArg.add(list);
                      //   }
                      // }

                      return TaskPage(
                        label: "Team Tasks",
                        workspace: widget.workspace,
                        taskLists: listArg,
                      );
                    }
                  }),
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
      // lists.add(list);
    });
  }

  Future<void> deleteList(WorkList list) async {
    var reference = Firestore.instance.collection('lists').document(list.id);
    await reference.delete();

    setState(() {
      displayLists.remove(list);
      // lists.remove(list);
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
          SelectableText(widget.label,
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
                  return CreateTaskListDialog(
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

                      // for (Task task in tasks) {
                      //   if (task.list.id == e.id) {
                      //     thisTasks.add(task);
                      //   }
                      // }

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
