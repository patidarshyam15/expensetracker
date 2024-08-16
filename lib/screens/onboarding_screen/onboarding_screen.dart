
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/onboarding_contents.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../constants/color_const.dart';
import '../../storage/app_storage.dart';
import '../../utils/common_style.dart';
import '../login_registraion/login_register_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
  }

  int _currentPage = 0;

  AnimatedContainer _buildDots({
    int? index,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        color: Color(0xFF000000),
      ),
      margin:  EdgeInsets.only(right: 5.sp),
      height: 10.sp,
      curve: Curves.easeIn,
      width: _currentPage == index ? 20.sp : 10.sp,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              // color: Colors.red,
              height: 70.h,
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: contents.length,
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 20.h,),
                      Image.asset(contents[i].image, height: 35.h),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: CommonStyle.black20Bold()
                      ),
                       SizedBox(height: 10.sp),
                      Text(
                        contents[i].desc,
                        style: CommonStyle.black12Normal(),
                        textAlign: TextAlign.center,
                      )
                    ],
                  );
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (int index) => _buildDots(
                      index: index,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 15.sp),
        child: _currentPage + 1 == contents.length
            ? CustomButton(
                color: AppColor.black,
                title: "Get Started",
                height: 35.sp,
                width: 70.w,
                onTap: () {
                  AppStorage appStorage = AppStorage();
                  appStorage.setFirstIntro("true");
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginRegistrationScreen()));
                },
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    color: AppColor.black,
                    title: "Skip",
                    height: 35.sp,
                    width: 25.w,
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                  ),
                  CustomButton(
                    color: AppColor.primary,
                    title: "Next",
                    height: 35.sp,
                    width: 25.w,
                    onTap: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
