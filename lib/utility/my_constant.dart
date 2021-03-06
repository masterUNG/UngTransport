import 'package:flutter/material.dart';

class MyConstant {
  //field
  static Color primary = const Color.fromARGB(255, 18, 110, 8);
  static Color dark = const Color.fromARGB(255, 3, 39, 93);
  static Color light = const Color.fromARGB(255, 226, 205, 40);

  static String keyRollerId = 'rollerid';
  static String keyUserName = 'username';
  static String keyPassword = 'password';
  static String keyToken = 'token';

  static List<String> typeUsers = [
    'Owner',
    'Customer',
    'Driver',
  ];

  static String pathRegister =
      'https://www.rollerglobal.com/api/api/Member/register';
  static String pathAuthen =
      'https://www.rollerglobal.com/api/api/Member/login';
  static String pathGetProfile =
      'https://www.rollerglobal.com/api/api/Member/getprofile';

  //method

  BoxDecoration curveBorderBox() => BoxDecoration(
        border: Border.all(color: MyConstant.dark),
        borderRadius: BorderRadius.circular(15),
      );

  BoxDecoration planBox() => BoxDecoration(color: light.withOpacity(0.5));

  BoxDecoration imageBox() => const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
      );

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
