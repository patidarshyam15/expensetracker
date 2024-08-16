import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AppColor {
  static const lightPrimary = Color(0xffedf3f5);
  static const primary = Color(0xfffa8f02);
  static const primary1 = Color(0xfffaf3eb);
  static const grade = Color(0xfff5b35d);
  static const transParent = Colors.transparent;
  // static const primary1 = Color(0xfffa8f02);
  // static const pink = Color(0xffb3366c);
  static const red = Color(0xffd62222);
  static const green = Colors.green;
  static const redLight = Color(0xffe8dfdf);
  static const greenLight = Color(0xffdff7e5);
  static const grey =  Color(0xffd5dae3);
  static const black = Colors.black;
  static const blue = Colors.blue;
  // static const grey = Colors.grey;
  static const white = Colors.white;
  static const Gradient  colorGrade = LinearGradient(
    begin: Alignment.topLeft, // Start direction
    end: Alignment.bottomRight,
    colors: [
      // Color(0xfffaba66),
      AppColor.grade,
      AppColor.primary, // Start Color
      // End Color
      // End Color
    ], // Customize your colors here
  );

  static  Widget? flexibleSpace(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.sp),bottomRight: Radius.circular(15.sp)),
          gradient:  AppColor.colorGrade
      ),
    );
  }

  static const MaterialColor myColor = MaterialColor(
    0xfffa8f02,
    <int, Color>{
      50: Color(0xfffa8f02),
      100: Color(0xfffa8f02),
      200: Color(0xfffa8f02),
      300: Color(0xfffa8f02),
      400: Color(0xfffa8f02),
      500: Color(0xfffa8f02),
      600: Color(0xfffa8f02),
      700: Color(0xfffa8f02),
      800: Color(0xfffa8f02),
      900: Color(0xfffa8f02),
    },
  );
}
