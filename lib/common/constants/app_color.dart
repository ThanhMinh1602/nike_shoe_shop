import 'package:flutter/material.dart';

class AppColor {
  //Mobile
  static const primaryColor = Color(0xFF5B9EE1);
  static const backgroundColor = Color.fromARGB(255, 229, 241, 252);
  static const whiteColor = Colors.white;
  static const blackColor = Colors.black;
  static const textColor = Color(0xFF1A2530);
  static const redColor = Colors.red;
  static const subTextColor = Color(0xFF707B81);
  static const greyColor = Color(0xFFB4B4B4);
  static const greyColor300 = Color.fromARGB(255, 241, 241, 241);
  static const linerLoading = LinearGradient(colors: [
    AppColor.whiteColor,
    Color.fromARGB(45, 91, 158, 225),
    AppColor.whiteColor,
  ]);

  //web admin
  static const adminBackgroundColor = Color.fromARGB(255, 230, 229, 229);
  static const adminTextColor = Color(0xff262626);
}
