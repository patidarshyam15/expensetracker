import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_const.dart';
import '../utils/common_style.dart';

class Dialogs {
  static Future<void> showLoadingDialog() async {
    return Get.dialog(
      WillPopScope(
          onWillPop: () {
            return Future(() => false);
          },
          child: SimpleDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              children: <Widget>[
                Center(
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: CupertinoActivityIndicator(
                          color: AppColor.black, radius: 10),
                    ),
                  ),
                ),
              ])),
    );
  }
}

Widget loadingIndicator({double? height}) {
  return SizedBox(
    height: height ??  99.h,
      child:
          Center(child: const CupertinoActivityIndicator(color: AppColor.black, radius: 20)));
}



Widget noDataWidget({double? height,double? width}) {
  return SizedBox(
    height: height,
      width: width,
      child: Center(child: Text("Data Not Found".tr,textAlign: TextAlign.center,style: CommonStyle.grey12Normal(),)));
}

