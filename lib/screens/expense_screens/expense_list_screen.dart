
import 'package:expensetracker/provider_models/expense_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/color_const.dart';
import '../../../custom_widgets/custom_input_field.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../custom_widgets/circuler_indicator.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/date_time_picker.dart';
import '../../utils/common_style.dart';
import 'add_expense_screen.dart';


class ExpenseListScreen extends StatefulWidget {

  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {

  late ExpenseProvider provider ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<ExpenseProvider>(context, listen: false);
      provider.clearAll();
      provider.getExpenses();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, Widget? child) {
        return Scaffold(
          appBar: CustomAppBar(title: "Expense".tr,),
          backgroundColor: AppColor.white,
          body: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child:  Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.fromLTRB(8.0.sp, 8.0.sp, 8.0.sp, 8.0.sp),
                    child: CustomInputFieldSearch(
                      readOnly:  true,
                      controller: provider.searchCtrl,
                      onTap: () async {
                        DateTime? date = await DateTimePick().pickDate();
                        if(date!=null) provider.setSearchDate(date);
                      },
                      isDense: true,
                      prefixIcon: Icon(
                        size: 15.sp,
                        Icons.search,
                        color: AppColor.primary,
                      ),
                      suffixIcon: IconButton(
                        onPressed: (){
                         if(provider.searchCtrl.text.isNotEmpty) {
                           provider.searchCtrl.clear();
                           provider.notifyListeners();
                           provider.getExpenses();
                         }
                        },
                        icon: Icon(
                          size: 20.sp,
                          Icons.clear,
                          color: AppColor.primary,
                        ),
                      ),
                      labelText: 'Search by date'.tr,
                      hintText: 'Search by date'.tr,
                    ),
                  ),
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
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(width: 55.w, child: Text("\$${item.amount}",style: CommonStyle.black13Bold(),)),
                                                          SizedBox(width: 55.w, child: Text("${item.date}",style: CommonStyle.primary12Bold(),)),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          IconButton(onPressed: (){
                                                            Get.to(AddExpenseScreen(editData: item,));
                                                          }, icon: Icon(Icons.edit,size: 20.sp,)),
                                                          IconButton(onPressed: (){
                                                            removeExpense(item.id,context);
                                                          }, icon: Icon(Icons.delete,size: 20.sp,color: AppColor.red,)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
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
          ),
          floatingActionButton: GestureDetector(
            onTap: (){
              Get.to(AddExpenseScreen());
            },
            child: Padding(
              padding:  const EdgeInsets.all(4.0),
              child: Container(
                constraints: BoxConstraints(
                    maxWidth: 45.w
                ),
                height: 35.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.sp),
                  gradient: AppColor.colorGrade,
                ),
                child: Center(
                  child: Text('Add Expense'.tr,style: CommonStyle.white12Normal(),),
                ),
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        );
      },
    );

  }

  void removeExpense(expenseId,BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Consumer<ExpenseProvider>(
              builder: (context, provider, Widget? child) {
                return AlertDialog(
                  surfaceTintColor: AppColor.white,

                  shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0.sp))),
                  title: Center(child: Text("Are you sure?".tr)),
                  content:
                   Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Center(
                        child: Text(
                            'Do you really want to delete Expense?'.tr)),
                  ]),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    TextButton(
                      child: Text("Cancel".tr,style: CommonStyle.black12Normal()),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text("Yes".tr,style: CommonStyle.black12Normal()),
                      onPressed: () async {
                        provider.deleteExpense(expenseId);
                      },
                    ),
                  ],
                );
              },
            );

          },
        );
      },
    );
  }

}



