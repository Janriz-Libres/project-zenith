import 'package:flutter/material.dart';

class DrawOption extends StatelessWidget {
  final String imgPath;
  final String text;

  const DrawOption({
    super.key,
    required this.imgPath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          Image.asset(
            imgPath,
            width: 50,
            height: 50,
          ),
          Text(
            text,
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
    );
  }
}
