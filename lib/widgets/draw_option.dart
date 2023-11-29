import 'package:flutter/material.dart';

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
