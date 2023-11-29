import 'package:flutter/material.dart';
import 'package:project_zenith/widgets/authpage_textfield.dart';

class WorkspaceField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const WorkspaceField({super.key, required this.label, required this.controller});

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
                  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
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