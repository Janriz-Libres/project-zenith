import 'package:flutter/material.dart';

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