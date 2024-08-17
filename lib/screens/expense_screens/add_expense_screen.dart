import 'package:expensetracker/data_models/expense_list_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import '../../../constants/color_const.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../utils/common_style.dart';
import '../../custom_widgets/custom_app_bar.dart';
import '../../custom_widgets/custom_input_field.dart';
import '../../custom_widgets/date_time_picker.dart';
import '../../provider_models/expense_provider.dart';
import '../../storage/local_database.dart';

class AddExpenseScreen extends StatefulWidget {
  final ExpenseListData? editData;
  const AddExpenseScreen({Key? key, this.editData}) : super(key: key);

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  late ExpenseProvider provider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.editData != null) {
        provider = Provider.of<ExpenseProvider>(context, listen: false);
        provider.setEditExpense(widget.editData!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, provider, Widget? child) {
        return Scaffold(
          backgroundColor: AppColor.primary1,
          appBar: CustomAppBar(
            title: "Expense".tr,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15.sp,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Card(
                          surfaceTintColor: AppColor.white,
                          color: AppColor.white,
                          child: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Column(
                              children: [
                                CustomInputField(
                                  keyboardType: TextInputType.number,
                                  controller: provider.amountCtrl,
                                  labelText: 'Amount'.tr,
                                  hintText: 'Amount'.tr,
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                CustomInputField2(
                                  controller: provider.dateCtrl,
                                  onTap: () async {
                                    DateTime? date =
                                        await DateTimePick().pickDate();
                                    if (date != null)
                                      provider.setStartDate(date);
                                  },
                                  readOnly: true,
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: AppColor.black,
                                  ),
                                  hintText: 'Select Date'.tr,
                                  labelText: 'Select Date'.tr,
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                CustomInputField2(
                                  controller: provider.descriptionCtrl,
                                  maxLines: 4,
                                  labelText: 'Description'.tr,
                                  hintText: 'Description'.tr,
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        CustomButton(
                            color: AppColor.primary,
                            title: "Submit".tr,
                            height: 35.sp,
                            // width: 80.w,
                            onTap: () async {
                              widget.editData != null
                                  ? provider.submitExpense(isEdit: true)
                                  : provider.submitExpense(isEdit: false);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
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
}
