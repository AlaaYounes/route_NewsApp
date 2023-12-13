import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff39A552);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color redColor = Color(0xffC91C22);
  static Color navyBlueColor = Color(0xff003E90);
  static Color pinkColor = Color(0xffED1E79);
  static Color brownColor = Color(0xffCF7E48);
  static Color blueColor = Color(0xff4882CF);
  static Color yellowColor = Color(0xffF2D352);
  static Color blackColor = Color(0xff303030);
  static Color greyColor = Color(0xff79828B);
  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.transparent,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: whiteColor,
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
        color: blackColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: TextStyle(
        color: whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        color: whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        color: blackColor,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        color: greyColor,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
