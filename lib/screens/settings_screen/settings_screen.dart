
import 'package:expensetracker/custom_widgets/custom_app_bar.dart';
import 'package:expensetracker/provider_models/expense_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../constants/color_const.dart';
import '../../utils/common_style.dart';
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<HomeScreenProvider>(context, listen: false).homeDetailApi();
    super.initState();
    // initStep();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, Widget? child) {
        return Scaffold(

          backgroundColor: AppColor.white,

         appBar: CustomAppBar(title: "Setting".tr,),
          body: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 12.sp,vertical: 10.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    provider.setLangData("en");
                  },
                  child: Container(
                    width: 95.w,
                    height: 50.sp,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          height: 18.sp,
                          width: 18.sp,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.7,color:AppColor.primary),
                              shape: BoxShape.circle,
                              color: AppColor.white
                          ),
                          child: Center(
                            child: Container(
                              height: 10.sp,
                              width: 10.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: provider.lang == "en"? AppColor.primary: Colors.grey.withAlpha(150),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.sp,),
                        Text(
                          "English",
                          style: CommonStyle.black12Bold(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.sp,),
                InkWell(
                  onTap: () async {
                    provider.setLangData("ar");
                  },
                  child: Container(
                    width: 95.w,
                    height: 50.sp,
                    child: Row(
                      children: [

                        Container(
                          height: 18.sp,
                          width: 18.sp,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.7,color:AppColor.primary),
                              shape: BoxShape.circle,
                              color: AppColor.white
                          ),
                          child: Center(
                            child: Container(
                              height: 10.sp,
                              width: 10.sp,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: provider.lang == "ar"? AppColor.primary: Colors.grey.withAlpha(150),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.sp,),
                        Text(
                          "عربي",
                          style: CommonStyle.black12Bold(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.sp,),
              ],
            ),
          ),

        );
      },
    );
  }




}



