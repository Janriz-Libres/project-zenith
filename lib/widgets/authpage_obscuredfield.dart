import 'package:flutter/material.dart';

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
