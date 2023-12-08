import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project_zenith/custom_widgets.dart';
import 'package:project_zenith/db_api.dart';
import 'package:project_zenith/globals.dart';
import 'package:project_zenith/pages/members_page.dart';

class WorkspacePage extends StatefulWidget {
  final Workspace workspace;
  final Function(Workspace) callback;

  const WorkspacePage({
    super.key,
    required this.workspace, 
    required this.callback,
  });

  @override
  State<WorkspacePage> createState() => _WorkspacePageState();
}

enum ContentWidget { task, members }

class _WorkspacePageState extends State<WorkspacePage> {
  ContentWidget contentWidget = ContentWidget.task;

  final boardNameController = TextEditingController();
  final tasklistNameController = TextEditingController();

  late Workspace workspace = widget.workspace;

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
          ConstrainedBox(
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
                        Expanded(
                          flex: 18,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.workspace.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
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
                      func:  () => _changeContent(ContentWidget.members),
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
                                      boardNameController.clear();
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
          Expanded(
            flex: 3,
            child: SelectionArea(
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
                        left: 30, right: 30, top: 80, bottom: 30),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        switch (contentWidget) {
                          case ContentWidget.task:
                            return TaskPage(
                              workspace: workspace, 
                              callback: (Workspace tempspace) {
                                Workspace space = widget.callback(tempspace);
                                setState(() {
                                  workspace = space;
                                });
                              }
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
          ),
        ],
      ),
    );
  }
}

class TaskPage extends StatefulWidget {
  final Workspace workspace;
  final Function(Workspace) callback;

  const TaskPage({
    super.key,
    required this.workspace, 
    required this.callback,
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final tasklistNameController = TextEditingController();
  List<WorkList>? worklists;
  final newDesc = TextEditingController();
  bool editable = false;
  bool disabled = true;
  bool edit = false;
  Color color = Colors.grey;
  late Workspace workspace = widget.workspace;

  Future<void> _addWorklist() async {
    WorkList list = await widget.workspace.addList(tasklistNameController.text);

    setState(() {
      worklists?.add(list);
    });

    gLists.add(list);
  }

  void _initWorklists() {
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

  void _removeList(WorkList list) {
    setState(() {
      worklists?.remove(list);
    });
  }

  @override
  void dispose() {
    tasklistNameController.dispose();
    newDesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _initWorklists();

    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      !editable ? MouseRegion(
        onEnter: (event) => setState(() {
          edit = true;
        }),
        onExit: (event) => setState(() {
          edit = false;
        }),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            workspace.description.isNotEmpty ? Flexible(
              child: Text(
                workspace.description,
                style: const TextStyle(
                  color: Color(0xFF636769),
                  fontSize: 15,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ) : const Flexible(
              child: Text(
                "Description",
                style: TextStyle(
                  color: Color(0xFF636769),
                  fontSize: 15,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedOpacity(
              opacity: edit ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: IconButton(
                  iconSize: 20,
                  onPressed: () {
                    setState(() {
                      editable = true;
                    });
                  }, 
                  icon: const Icon(Icons.edit, color: Colors.black87,)),
              ),
            )
          ],
        ),
      ) : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 5,
                  controller: newDesc,
                  decoration: const InputDecoration(
                    hintText: "Description"
                  ),
                  style: const TextStyle(
                    color: Color(0xFF636769),
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w400,
                    fontSize: 15
                  ),
                  onChanged: (text) {
                    if (text.isEmpty) {
                      setState(() {
                        disabled = true;
                        color = Colors.grey;
                      });
                    } else {
                      setState(() {
                        disabled = false;
                        color = Colors.black87;
                      });
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  newDesc.clear();
                  setState(() {
                    editable = false;
                    disabled = true;
                    edit = false;
                    color = Colors.grey;
                  });
                }, 
                icon: const Icon(Icons.close, color: Colors.red)),
              IconButton(
                onPressed: disabled ? null : 
                () async {
                  Workspace space = await gUser!.updateSpaceDesc(widget.workspace, newDesc.text);
                  widget.callback(space);
                  setState(() {
                    workspace = space;
                    editable = false;
                    disabled = true;
                    edit = false;
                    color = Colors.grey;
                  });
                  newDesc.clear();
                }, 
                icon: Icon(Icons.subdirectory_arrow_left, color: color)
              )
            ],
          ),
      const SizedBox(height: 10,),
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
                    func: _addWorklist,
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
                    children: worklists!.map((e) => TaskList(
                      list: e, 
                      worklists: worklists!, 
                      func: _removeList,
                      callback: (String name) async {
                        WorkList list = gLists.firstWhere((element) => e.id == element.id);
                        int index = gLists.indexWhere((element) => e.id == element.id);
                        gLists[index] = await widget.workspace.updateListName(e, name);
                        int indexWorkList = gLists.indexWhere((element) => gLists[index].id == element.id);
                        worklists![indexWorkList] = gLists[index];
                        setState(() {
                          e = list;
                        });
                      },
                      deleteFunc: (WorkList list) {
                        setState(() {
                          worklists!.remove(list);
                        });
                        gLists.remove(list);
                      },
                      )
                    ).toList(),
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
  WorkList list;
  final List<WorkList> worklists;
  final Function(WorkList) func;
  final Function(String) callback;
  final Function(WorkList) deleteFunc;

  TaskList({
    super.key,
    required this.list, 
    required this.worklists, 
    required this.func, 
    required this.callback, 
    required this.deleteFunc,
  });

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<Task>? tasks;
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final newName = TextEditingController();
  bool editable = false;
  bool disabled = true;
  bool editName = false;
  bool editBg = false;
  Color color = Colors.grey;

  Future<void> _addTask() async {
    Task newTask =
        await widget.list.addTask(titleController.text, descController.text);

    setState(() {
      tasks?.add(newTask);
    });

    gTasks.add(newTask);
  }

  void _removeTask(Task task) {
    setState(() {
      tasks?.remove(task);
    });
    gTasks.remove(task);
  }
  
  Future<void> _completeTask(Task task) async {
    await widget.list.deleteTask(task);
    _removeTask(task);
  }

  Future<void> _moveTask(TaskFuncPair data) async {
    setState(() {
      tasks?.add(data.task);
    });

    await data.func();
    await data.task.changeParentList(widget.list);
  }

  void _deleteTasks() {
    for (Task task in tasks!) {
      _completeTask(task);
    }
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
    newName.dispose();
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
                    !editable ? Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.list.name.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  tasks!.isEmpty ? '${tasks!.length} task' : '${tasks!.length} tasks',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontFamily: "Rubik",
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MenuAnchor(
                            builder: (BuildContext context, MenuController controller,
                                Widget? child) {
                              return IconButton(
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                                icon: const Icon(Icons.more_horiz),
                                tooltip: 'Show menu',
                              );
                            },
                            menuChildren: [
                              MenuItemButton(
                                onPressed: () async {
                                  setState(() {
                                    editable = true;
                                  });
                                },
                                child: const Text('Edit Worklist'),
                              ),
                              MenuItemButton(
                                onPressed: () async {
                                  _deleteTasks();
                                  await widget.list.workspace.deleteList(widget.list);
                                  widget.deleteFunc(widget.list);
                                },
                                child: const Text('Delete'),
                              ),
                            ]
                          ),
                        ],
                      ),
                    ) : Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: newName,
                              decoration: InputDecoration(
                                hintText: widget.list.name.toUpperCase(),
                                hintStyle: const TextStyle(
                                  color: Colors.grey
                                )
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Rubik",
                                fontWeight: FontWeight.w500
                              ),
                              onChanged: (text) {
                                if (text == widget.list.name || text.isEmpty) {
                                  setState(() {
                                    disabled = true;
                                    color = Colors.grey;
                                  });
                                } else {
                                  setState(() {
                                    disabled = false;
                                    color = Colors.white;
                                  });
                                }
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              newName.clear();
                              setState(() {
                                editable = false;
                                disabled = true;
                                editName = false;
                                color = Colors.grey;
                              });
                            }, 
                            icon: const Icon(Icons.close, color: Colors.red)),
                          IconButton(
                            onPressed: disabled ? null : 
                            () async {
                              widget.list = await widget.list.workspace.updateListName(widget.list, newName.text);
                              widget.callback(newName.text);
                              newName.clear();
                              setState(() {
                                editable = false;
                                disabled = true;
                                editName = false;
                                color = Colors.grey;
                              });
                            }, 
                            icon: Icon(Icons.subdirectory_arrow_left, color: color)
                          )
                        ],
                      ),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          children: tasks!
                              .map(
                                (e) => Draggable<TaskFuncPair>(
                                  data: TaskFuncPair(
                                    task: e,
                                    func: () {_removeTask(e);},
                                  ),
                                  feedback: TaskCard(
                                    data: TaskFuncPair(
                                      task: e,
                                      func: () async {await _completeTask(e);},
                                    )
                                  ),
                                  childWhenDragging: Container(),
                                  child: TaskCard(
                                    data: TaskFuncPair(
                                      task: e,
                                      func: () async {await _completeTask(e);},
                                    )
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
                              titleController.clear();
                              descController.clear();
                              return CreateTaskDialog(
                                taskNameController: titleController,
                                taskDescriptionController: descController, 
                                func: _addTask
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

class TaskCard extends StatefulWidget {
  final TaskFuncPair data;

  const TaskCard({
    super.key, required this.data,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  User? dropdownValue;
  List<User>? assignees;

  void init() {
    if (assignees != null) {
      return;
    }

    assignees = <User>[];

    setState(() {
      assignees?.add(widget.data.task.list.workspace.owner);

      for (User member in widget.data.task.list.workspace.members) {
        assignees?.add(member);
      }
    });

    for (User user in assignees!) {
      print(user.username);
    }
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
            //set border radius more than 50% of height and width to make circle
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
          child: SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<User>(
                  hint: const Text("assignee"),
                  value: dropdownValue,
                  onChanged: (User? user) {
                    // This is called when the user selects an item.
                    setState(() {
                      dropdownValue = user!;
                    });
                  },
                  items: assignees!.map<DropdownMenuItem<User>>((User user) {
                    return DropdownMenuItem<User>(value: user, child: Text(user.username));
                  }).toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    isCollapsed: true
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.data.task.description.isEmpty ? Container() : SizedBox(
                            width: 180,
                            child: Text(
                              widget.data.task.description,
                              style: const TextStyle(
                                fontFamily: "Rubik",
                                fontSize: 12,
                                color: Colors.black87
                              ),
                            ),
                          ),
                          Text(
                            widget.data.task.title,
                            style: const TextStyle(
                              fontFamily: "Rubik",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: widget.data.func,
                        icon: const Icon(Icons.check, 
                        color: Colors.green,)
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskFuncPair {
  final Task task;
  final Function() func;

  const TaskFuncPair({
    required this.task,
    required this.func,
  });
}
