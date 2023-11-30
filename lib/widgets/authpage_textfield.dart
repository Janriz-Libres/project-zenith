import 'package:flutter/material.dart';

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
