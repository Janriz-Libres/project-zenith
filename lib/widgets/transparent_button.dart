import 'package:flutter/material.dart';

class TransparentButton extends StatelessWidget {
  final String text;
  final Color flat;
  final Color hovered;
  final Color lineColor;
  final Function() function;

  const TransparentButton({
    super.key,
    required this.text,
    required this.flat,
    required this.hovered,
    required this.lineColor,
    required this.function
  });

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
    /* return Container(
      color: Colors.transparent,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
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
  */
  }
}