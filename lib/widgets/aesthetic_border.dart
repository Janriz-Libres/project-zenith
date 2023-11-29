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
