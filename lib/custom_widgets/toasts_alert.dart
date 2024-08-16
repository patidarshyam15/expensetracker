import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/color_const.dart';
import '../utils/common_style.dart';

void errorToastMessage(String message) {
  CherryToast.error(
    title: Text("Error!".tr, style: CommonStyle.red12Normal(),),
      description:  Text(message, style: CommonStyle.black10Normal(),textAlign: TextAlign.center,),
      animationType:  AnimationType.fromBottom,
      toastPosition:  Position.bottom,
      backgroundColor: AppColor.white,
      animationDuration:  const Duration(milliseconds:  500),
      toastDuration: const Duration(seconds: 4),
      autoDismiss:  true
  ).show(Get.context!);
}

void successToastMessage(String message) {
  CherryToast.success(
      title: Text("Success!".tr, style: CommonStyle.green12Normal(),),
      description:  Text(message, style: CommonStyle.black10Normal(),),
      animationType:  AnimationType.fromBottom,
      toastPosition:  Position.bottom,
      backgroundColor: AppColor.greenLight,
      animationDuration:  const Duration(milliseconds:  500),
      toastDuration: const Duration(seconds: 4),
      autoDismiss:  true
  ).show(Get.context!);
}


