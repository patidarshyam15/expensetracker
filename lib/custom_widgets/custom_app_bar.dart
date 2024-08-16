import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_const.dart';
import '../utils/common_style.dart';




class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: AppColor.flexibleSpace(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.sp),
            bottomRight: Radius.circular(15.sp)),
      ),
      // backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
      elevation: 1,
      shadowColor: AppColor.black,
      // leading: Icon(Icons.person,size: 20.sp,),
      title: Text(title, style: CommonStyle.white17Normal()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
