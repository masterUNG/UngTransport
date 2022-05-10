import 'package:flutter/material.dart';

class MyConstant {
  //field
  static Color primary = const Color.fromARGB(255, 18, 110, 8);
  static Color dark = const Color.fromARGB(255, 3, 39, 93);
  static Color light = const Color.fromARGB(255, 226, 205, 40);

  //method

  BoxDecoration planBox() => BoxDecoration(color: light.withOpacity(0.5));

  TextStyle h1Style() {
    return TextStyle(
      color: dark,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle h2Style() {
    return TextStyle(
      color: dark,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    );
  }

  TextStyle h3Style() {
    return TextStyle(
      color: dark,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  TextStyle h3ActiveStyle() {
    return const TextStyle(
      color: Color.fromARGB(255, 197, 16, 76),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }
} // class
