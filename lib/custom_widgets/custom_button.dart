
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_const.dart';
import '../utils/common_style.dart';


class CustomButton extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Color color;
  final void Function()? onTap;
  const CustomButton({super.key, this.width,this.onTap, this.height,required this.title,required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            gradient: AppColor.colorGrade,
            borderRadius: BorderRadius.circular(20.sp),
          ),
          height: height,
          width: width,
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.sp),
              child: Text("$title",style: CommonStyle.white12Normal(),),
            ),
          )
      ),
    );
  }
}



class CustomButtonSignUp extends StatelessWidget {
  final String title;
  final double? width;
  final double? height;
  final Color color;
  final void Function()? onTap;
  const CustomButtonSignUp({super.key, this.width,this.onTap, this.height,required this.title,required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: AppColor.white,borderRadius: BorderRadius.circular(20.sp),
              border: Border.all(width: 1,color: color)
          ),
          height: height,
          width: width,
          child: Center(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.sp),
              child: Text("$title",style: TextStyle(color: AppColor.black,fontWeight: FontWeight.bold),),
            ),
          )
      ),
    );
  }
}