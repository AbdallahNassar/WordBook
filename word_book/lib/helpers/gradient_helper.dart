import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientHelper {
  //============================================================================
  static const List<Color> gradientColors = [
    Color(0xFF8C2480),
    Color(0xFFCE587D),
    Color(0xFFFF9485),
    Color(0xFFFF9D80),
  ];
  //============================================================================
  static const LinearGradient linearGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: gradientColors,
  );
  //============================================================================
  static Shader mGetShader(context, width, height) {
    return LinearGradient(
      // reverse the color gradient in the text
      colors: List.from(gradientColors.reversed),
    ).createShader(
      Rect.fromLTWH(
        0,
        0,
        width,
        height,
      ),
    );
  }

  //============================================================================
  static TextStyle mGetSearchCardTextStyle(context, width, height) {
    return Platform.isIOS
        ? CupertinoTheme.of(context).textTheme.pickerTextStyle.copyWith(
              foreground: Paint()..shader = mGetShader(context, width, height),
            )
        : Theme.of(context).textTheme.button.copyWith(
              foreground: Paint()..shader = mGetShader(context, width, height),
            );
  }
}
