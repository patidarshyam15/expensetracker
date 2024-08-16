import 'dart:math';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/toasts_alert.dart';
import '../../../routes/route_name.dart';
import '../../constants/color_const.dart';
import '../../custom_widgets/custom_input_field.dart';
import '../../provider_models/login_registraion_provider.dart';
import '../../utils/common_style.dart';


class LoginRegistrationScreen extends StatefulWidget {
  const LoginRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<LoginRegistrationScreen> createState() => _LoginRegistrationScreenState();
}

class _LoginRegistrationScreenState extends State<LoginRegistrationScreen>
    with SingleTickerProviderStateMixin {
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Start at the controller and set the time to switch pages
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginRegisterProvider>(
      builder: (context, provider, Widget? child) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppColor.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20.sp,
                  ),
                  Container(
                    height: 150.sp,
                    child: Image.asset("assets/images/onboarding1.png",height: 100.sp,width: 100.sp,),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.sp),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 52.w,
                            height: 45.sp,
                            decoration: BoxDecoration(
                              color: AppColor.grey,
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child:  Padding(
                              padding:  EdgeInsets.all(8.0.sp),
                              child: AnimatedToggleSwitch<int>.size(
                                current: min(provider.selectedToggle, 2),
                                style: ToggleStyle(
                                  backgroundColor: AppColor.grey,
                                  indicatorColor: AppColor.white,
                                  borderColor: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10.sp),
                                  indicatorBorderRadius: BorderRadius.zero,
                                ),
                                values: const [0, 1],
                                iconOpacity: 1.0,
                                selectedIconScale: 1.0,
                                indicatorSize: const Size.fromWidth(100),
                                iconAnimationType: AnimationType.onHover,
                                styleAnimationType: AnimationType.onHover,
                                spacing: 2.0,
                                customSeparatorBuilder: (context, local, global) {
                                  final opacity =
                                  ((global.position - local.position).abs() - 0.5)
                                      .clamp(0.0, 1.0);
                                  return VerticalDivider(
                                      indent: 10.0,
                                      endIndent: 10.0,
                                      color: Colors.white38.withOpacity(opacity));
                                },
                                customIconBuilder: (context, local, global) {
                                  final text =  ['Login'.tr, 'Register'.tr][local.index];
                                  return Center(
                                      child: Text(text,
                                          style: TextStyle(
                                              color: Color.lerp( Colors.black, Colors.black,
                                                  local.animationValue))));
                                },
                                borderWidth: 0.0,
                                onChanged: (i) {
                                  provider.setSelectedToggle(i);
                                } ,
                              ),
                            ),),
                        if(provider.selectedToggle == 0) loginSection() else registerSection()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  Widget loginSection() {
  return  Consumer<LoginRegisterProvider>(
      builder: (context, provider, Widget? child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInputField(
                    controller: provider.loginEmailCtrl,
                    isDense: true,
                    prefixIcon: Icon(
                      size: 15.sp,
                      Icons.person,
                      color: AppColor.black,
                    ),
                    labelText: 'Email'.tr,
                    hintText: 'Enter Email Id'.tr,
                ),
                SizedBox(
                  height: 12.sp,
                ),
                CustomInputField(
                  controller: provider.pwdCtrl,
                  isDense: true,
                  prefixIcon: Icon(
                    size: 15.sp,
                    Icons.lock_open,
                    color: AppColor.black,
                  ),
                  labelText: 'Password'.tr,
                  hintText: 'Password'.tr,
                  obscureText: true,
                  suffixIcon: true,
                ),
                SizedBox(
                  height: 12.sp,
                ),

                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    color: AppColor.primary,
                    title: "Login".tr,
                    height: 35.sp,
                    // width: 80.w,
                    onTap: () async {
                      provider.submitSignIn();
                      Get.offAllNamed(RouteName.LOGIN_REGISTER);
                    }),
                SizedBox(
                  height: 10.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget registerSection() {
    return  Consumer<LoginRegisterProvider>(
      builder: (context, provider, Widget? child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomInputField(
                  controller: provider.registerEmailCtrl,
                    isDense: true,
                    prefixIcon: Icon(
                      size: 15.sp,
                      Icons.email_outlined,
                      color: AppColor.black,
                    ),
                    labelText: 'Email'.tr,
                    hintText: 'Enter Email Id'.tr,
                    ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomInputField(
                  controller: provider.registerPwdCtrl,
                  isDense: true,
                  prefixIcon: Icon(
                    size: 15.sp,
                    Icons.lock_open,
                    color: AppColor.black,
                  ),
                  labelText: 'Password'.tr,
                  hintText: 'Password'.tr,
                  obscureText: true,
                  suffixIcon: true,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                CustomInputField(
                  controller: provider.registerConfirmPwdCtrl,
                  isDense: true,
                  prefixIcon: Icon(
                    size: 15.sp,
                    Icons.lock_open,
                    color: AppColor.black,
                  ),
                  labelText: 'Confirm Password'.tr,
                  hintText: 'Confirm Password'.tr,
                  obscureText: true,
                  suffixIcon: true,

                ),
                SizedBox(
                  height: 20.sp,
                ),
                CustomButton(
                    color: AppColor.primary,
                    title: "Register".tr,
                    height: 35.sp,
                    // width: 80.w,
                    onTap: () async {
                     provider.submitSignUp();
                    }),
                SizedBox(
                  height: 20.sp,
                ),


              ],
            ),
          ),
        );
      },
    );
  }
}
