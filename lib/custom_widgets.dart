import 'package:flutter/material.dart';

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

class WorkspaceField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const WorkspaceField(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            child: FittedBox(
              child: Text(
                label,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Color(0xFFFFE66D),
                  fontSize: 30,
                  fontFamily: 'DM Sans',
                  height: 0,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              InputWidget(
                validator: (value) {
                  const pattern =
                      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                  final regex = RegExp(pattern);

                  return value!.isNotEmpty && !regex.hasMatch(value)
                      ? 'Enter a valid email address'
                      : null;
                },
                controller: controller,
                labelText: "Enter workspace name",
                obscured: true,
                widget: Container(
                  width: 17,
                  height: 17,
                  decoration: const ShapeDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/signup_ellipse.png")),
                    shape: OvalBorder(),
                  ),
                ),
                borderColor: const Color(0xFFFFE66D),
                enabledColor: const Color(0xFFFFE66D),
                focusedColor: const Color(0xFF06BCC1),
              ),
            ],
          ),
        ),
      ],
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

  const ObscuredField(
      {super.key,
      required this.labelText,
      required this.widget,
      required this.borderColor,
      required this.enabledColor,
      required this.focusedColor,
      required this.controller});

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

class InputWidget extends StatelessWidget {
  final String labelText;
  final bool obscured;
  final Widget widget;
  final TextEditingController controller;
  final Color borderColor;
  final Color enabledColor;
  final Color focusedColor;
  final String? Function(String?)? validator;

  const InputWidget(
      {super.key,
      required this.labelText,
      required this.obscured,
      required this.widget,
      required this.borderColor,
      required this.enabledColor,
      required this.focusedColor,
      required this.controller,
      required this.validator});

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
              validator: validator,
              controller: controller,
              obscureText: obscured,
              style: const TextStyle(fontSize: 14, color: Colors.white),
              maxLines: 1,
              decoration: InputDecoration(
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
  const MemberCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 75,
      child: Card(
        color: Color(0xFFD4515D),
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
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Username",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  Text(
                    "Email Address",
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

class TaskList extends StatelessWidget {
  final String label;

  const TaskList({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: SizedBox(
        width: 375,
        child: Card(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            //set border radius more than 50% of height and width to make circle
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        label.toUpperCase(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.w700,
                            fontSize: 18),
                      ),
                      IconButton(
                          icon: const Icon(Icons.more_horiz), onPressed: () {})
                    ],
                  ),
                ),
                const Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TaskCard(),
                      ],
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
                            style: TextStyle(fontFamily: "Rubik", fontSize: 16),
                          )
                        ],
                      ),
                      onPressed: () {}),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
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
