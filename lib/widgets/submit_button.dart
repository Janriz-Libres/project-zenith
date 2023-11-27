import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String text;
  final List<Color> gradient;
  final Function() function;

  const SubmitButton({
    super.key,
    required this.text,
    required this.gradient,
    required this.function
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
        onPressed: function,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(300, 70),
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
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