import 'dart:math';
import 'package:expensetracker/custom_widgets/custom_app_bar.dart';
import 'package:expensetracker/provider_models/expense_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/color_const.dart';
import '../../../custom_widgets/circuler_indicator.dart';
import '../../../custom_widgets/custom_tab_bar.dart';
import '../../utils/common_style.dart';


class ExpenseSummaryScreen extends StatefulWidget {
  final String? appBar;
  const ExpenseSummaryScreen({super.key,this.appBar});

  @override
  State<ExpenseSummaryScreen> createState() => _ExpenseSummaryScreenState();
}

class _ExpenseSummaryScreenState extends State<ExpenseSummaryScreen>
    with SingleTickerProviderStateMixin {
  var rng = Random();
  late ExpenseProvider provider ;
  int initPosition = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<ExpenseProvider>(context, listen: false);
      provider.clearAll();
      initPosition == 0 ? provider.getExpensesWeekly(): provider.getExpensesMonthly();
    });
  }




  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, Widget? child) {
        List<String> tabTitle = ['Weekly'.tr,'Monthly'.tr];
        return Scaffold(
          backgroundColor: AppColor.white,
          appBar: CustomAppBar(title: "Summary".tr,),
          body: CustomTabView(
            initPosition: initPosition,
            itemCount: tabTitle.length,
            tabBuilder: (context, index) {
              return Tab(text: tabTitle[index]);
            },
            pageBuilder: (context, index){
              return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child:  Column(
                    children: [
                      !provider.loading? SizedBox(
                        height: 76.h,
                        child: AnimationLimiter(
                            child:provider.expenseList.isNotEmpty? ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: provider.expenseList.length,
                                itemBuilder: (context, index) {
                                  final item = provider.expenseList[index];
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 1300),
                                    child:  SlideAnimation(
                                      verticalOffset: 44.0,
                                      child: FadeInAnimation(
                                        child: Padding(
                                          padding:  EdgeInsets.fromLTRB(7.sp, 7.sp, 7.sp, index == provider.expenseList.length -1 ? 100.sp : 7.sp),
                                          child: GestureDetector(
                                            child: Padding(
                                              padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow:  [
                                                    BoxShadow(
                                                      color: AppColor.black.withAlpha(100),
                                                      blurRadius: 2.0,
                                                      offset: Offset(.5, .5),
                                                    ),
                                                  ],
                                                  color: AppColor.white,
                                                  // border:
                                                  // Border.all(width: .2, color: AppColor.black),
                                                  borderRadius: BorderRadius.circular(10.sp),
                                                ),
                                                child: Padding(
                                                  padding:  EdgeInsets.all(10.sp),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(width: 80.w, child: Text("${item.amount}",style: CommonStyle.black13Bold(),)),
                                                      SizedBox(width: 99.w, child: Text("${item.date}",style: CommonStyle.primary12Bold(),)),
                                                      SizedBox(width: 99.w, child: Text("${item.description}",textAlign: TextAlign.justify,style: CommonStyle.grey10Normal(),)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }
                            ):noDataWidget()),
                      ):loadingIndicator(height: 75.h),
                    ],
                  )
              );
            },
            onPositionChange: (index) {
              initPosition = index;
             index == 0 ? provider.getExpensesWeekly(): provider.getExpensesMonthly();
              print('initPosition------ $initPosition');
            },
            onScroll: (position) {
              print('------ $position');
            } ,
          )
        );
      },
    );


  }


}
