import 'dart:math';

import 'package:flutter/material.dart';

enum CustomIcon { 
  cyan("assets/build_icon.png"), 
  magenta("assets/join_icon.png"), 
  yellow("assets/later_icon.png"), 
  black("assets/extra_icon.png"), 
  white("assets/white_logo.png");

  const CustomIcon(this.asset);
  final String asset;
}

enum CustomColors<Colors> {
  cyan(Color(0xFF06BCC1)),
  magenta(Color(0xFFD4515D)),
  yellow(Color(0xFFFFE66D)),
  black(Color(0xFF313638));

  const CustomColors(this.color);
  final Color color;
}

extension ColorsOption<Colors> on CustomColors<Colors> {
  static CustomColors generateRandomColor() {
    var rnd = Random();
    return CustomColors.values[rnd.nextInt(CustomColors.values.length)];
  }
}