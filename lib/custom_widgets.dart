import 'package:flutter/material.dart';
import 'package:project_zenith/db_api.dart';
import 'package:firedart/firedart.dart';

class AestheticBorder extends StatelessWidget {
  final Color borderColor;
  final Color mainColor;
  final Widget child;

  const AestheticBorder({
    super.key,
    required this.borderColor,
    required this.mainColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Image.asset('assets/signup_ellipse_cropped.png'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 55.5, right: 55.5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 26.67,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(color: borderColor),
              ),
              Container(
                width: 13.33,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(color: borderColor),
              ),
              Container(
                width: 6.67,
                margin: const EdgeInsets.only(right: 6),
                decoration: BoxDecoration(color: borderColor),
              ),
              Expanded(
                child: Container(
                  decoration: ShapeDecoration(
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 4,
                        color: borderColor,
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputWidget extends StatelessWidget {
  final String labelText;
  final bool obscured;
  final Widget widget;
  final TextEditingController controller;
  final Color borderColor;
  final Color enabledColor;
  final Color focusedColor;

  const InputWidget({
    super.key,
    required this.labelText,
    required this.obscured,
    required this.widget,
    required this.borderColor,
    required this.enabledColor,
    required this.focusedColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Row(
        children: [
          Expanded(child: widget),
          Expanded(
            flex: 8,
            child: TextFormField(
              controller: controller,
              obscureText: obscured,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1,
              decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0),
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: enabledColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: focusedColor,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: borderColor,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.only(left: 20, right: 20),
                hintText: labelText,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 144, 142, 142),
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ObscuredField extends StatefulWidget {
  final String labelText;
  final Widget widget;
  final Color borderColor;
  final Color enabledColor;
  final Color focusedColor;
  final TextEditingController controller;

  const ObscuredField({
    super.key,
    required this.labelText,
    required this.widget,
    required this.borderColor,
    required this.enabledColor,
    required this.focusedColor,
    required this.controller,
  });

  @override
  State<ObscuredField> createState() => _ObscuredFieldState();
}

class _ObscuredFieldState extends State<ObscuredField> {
  bool obscured = true;

  void _toggle() {
    setState(() {
      obscured = !obscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Row(
        children: [
          Expanded(child: widget.widget),
          Expanded(
            flex: 8,
            child: TextFormField(
              controller: widget.controller,
              obscureText: obscured,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1,
              decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0),
                filled: true,
                fillColor: Colors.black,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: widget.enabledColor,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(
                    color: widget.focusedColor,
                    width: 2,
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: widget.borderColor,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                contentPadding: const EdgeInsets.only(left: 20, right: 20),
                hintText: widget.labelText,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 144, 142, 142),
                    fontWeight: FontWeight.normal),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        obscured ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                      onPressed: () {
                        _toggle();
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Copyright extends StatelessWidget {
  final double mLeft, mBot;

  const Copyright({
    super.key,
    required this.mLeft,
    required this.mBot,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      margin: EdgeInsets.only(left: mLeft, bottom: mBot),
      child: const Text(
        "Crusader Yearbook ©️ 2023",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: 'DM Sans',
          fontWeight: FontWeight.w400,
          height: 0,
        ),
      ),
    );
  }
}

class DrawOption extends StatefulWidget {
  final String imgPath;
  final String text;
  final Function() func;

  const DrawOption({
    super.key,
    required this.imgPath,
    required this.text,
    required this.func,
  });

  @override
  State<DrawOption> createState() => _DrawOptionState();
}

class _DrawOptionState extends State<DrawOption> {
  Color decor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => setState(() => decor = const Color(0xFFC7C7C7)),
      onExit: (event) => setState(() => decor = Colors.transparent),
      child: GestureDetector(
        onTap: widget.func,
        child: Container(
          decoration: BoxDecoration(color: decor),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Image.asset(
                  widget.imgPath,
                  width: 50,
                  height: 50,
                ),
              ),
              Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF636769),
                  fontSize: 18,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemberCard extends StatelessWidget {
  final User user;

  const MemberCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 75,
      child: Card(
        color: const Color(0xFFD4515D),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
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
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      color: Color(0xFF636769),
                      fontSize: 15,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SidebarList extends StatelessWidget {
  final List<Widget> children;

  const SidebarList({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final String text;
  final List<Color> gradient;
  final Size minSize;
  final Function() func;

  const SubmitButton({
    super.key,
    required this.text,
    required this.gradient,
    required this.minSize,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: const Alignment(0, -1),
          end: const Alignment(0, 1),
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
            minimumSize: minSize,
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            height: 0,
          ),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: 325,
        height: 90,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            //set border radius more than 50% of height and width to make circle
          ),
        ),
      ),
    );
  }
}

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
      // tasks.add(task);
    });
  }

  Future<void> deleteTasks() async {
    for (Task task in displayTasks) {
      var reference = Firestore.instance.collection('tasks').document(task.id);
      reference.delete();
    }

    setState(() {
      // tasks.removeWhere((element) => displayTasks.contains(element));
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

        // tasks.clear();
        // for (WorkList list in lists) {
        //   tasks.addAll(await list.getTasks());
        // }
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

class TransparentButton extends StatelessWidget {
  final String text;
  final Color flat;
  final Color hovered;
  final Color lineColor;
  final Function() function;

  const TransparentButton(
      {super.key,
      required this.text,
      required this.flat,
      required this.hovered,
      required this.lineColor,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered)) {
            return hovered;
          }
          return flat; // null throus error in flutter 2.2+.
        }),
      ),
      onPressed: function,
      child: FittedBox(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'DM Sans',
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.underline,
            decorationColor: lineColor,
            height: 0,
          ),
        ),
      ),
    );
  }
}

class JoinWorkspaceDialog extends StatelessWidget {
  const JoinWorkspaceDialog({
    super.key,
    required this.codeController,
  });

  final TextEditingController codeController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: SizedBox(
          width: 350,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 35, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        "Join an existing workspace",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: codeController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    hintText: "Enter workspace code",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SubmitButton(
                    text: "Enter",
                    gradient: const [Color(0xFF06BCC1), Color(0xFF168285)],
                    minSize: const Size(200, 50),
                    func: () async {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateBoardDialog extends StatelessWidget {
  const CreateBoardDialog({
    super.key,
    required this.boardNameController,
    required this.tasklistNameController,
  });

  final TextEditingController boardNameController;
  final TextEditingController tasklistNameController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: SizedBox(
          width: 350,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 35, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        "Create new board",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 12, right: 12),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: boardNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    hintText: "Enter board name",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 12, right: 12),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: tasklistNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    hintText: "Enter initial task list name",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SubmitButton(
                    text: "Enter",
                    gradient: const [Color(0xFF06BCC1), Color(0xFF168285)],
                    minSize: const Size(200, 50),
                    func: () async {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateTaskListDialog extends StatelessWidget {
  final TextEditingController tasklistNameController;
  final Function() func;

  const CreateTaskListDialog({
    super.key,
    required this.tasklistNameController,
    required this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: SizedBox(
          width: 350,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 35, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        "Create new task list",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 12, right: 12),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: tasklistNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    hintText: "Enter task list name",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SubmitButton(
                    text: "Enter",
                    gradient: const [Color(0xFF06BCC1), Color(0xFF168285)],
                    minSize: const Size(200, 50),
                    func: () async {
                      await func();

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateWorkspaceDialog extends StatelessWidget {
  const CreateWorkspaceDialog({
    super.key,
    required this.workspaceNameController,
    required this.workspaceDescriptionController,
    required this.func,
  });

  final TextEditingController workspaceNameController;
  final TextEditingController workspaceDescriptionController;
  final Future<void> Function() func;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        content: SizedBox(
          width: 350,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 25, bottom: 35, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 250,
                      child: Text(
                        "Create new workspace",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 12, right: 12),
                child: TextFormField(
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: workspaceNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    hintText: "Enter workspace name",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 12, right: 12),
                child: TextFormField(
                  maxLines: 3,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  controller: workspaceDescriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Color(0xFF06BCC1),
                        width: 2,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Color(0xFF06BCC1),
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    hintText: "Enter workspace description",
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 144, 142, 142),
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, right: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: SubmitButton(
                    text: "Enter",
                    gradient: const [Color(0xFF06BCC1), Color(0xFF168285)],
                    minSize: const Size(200, 50),
                    func: () async {
                      await func();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
