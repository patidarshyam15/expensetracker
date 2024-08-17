import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../constants/color_const.dart';
import '../../utils/common_style.dart';
import '../expense_screens/expense_list_screen.dart';
import '../expense_screens/expense_summary.dart';
import '../settings_screen/settings_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  final int? pageIndex;
  const BottomNavBarScreen({super.key, this.pageIndex});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  late int _selectedIndex = widget.pageIndex ?? 0;
  PageController pageController = PageController(initialPage: 0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() {
    setState(() {
      pageController = PageController(initialPage: widget.pageIndex ?? 0);
    });
  }

  String title = "Expense".tr;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          Center(
            child: ExpenseListScreen(),
          ),
          Center(
            child: ExpenseSummaryScreen(),
          ),
          Center(
            child: SettingsScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          iconSize: 20.sp,
          elevation: 24,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedFontSize: 13,
          selectedItemColor: AppColor.primary,
          unselectedFontSize: 10.sp,
          unselectedItemColor: AppColor.black.withAlpha(170),
          unselectedLabelStyle: CommonStyle.black12Normal(),
          onTap: (index) {
            // int lastIndex = _selectedIndex;
            setState(() {
              _selectedIndex = index;
            });
            setState(() {
              pageController.jumpToPage(index);
              _selectedIndex == 0
                  ? title = "Expense".tr
                  : index == 1
                      ? title = "Summary".tr
                      : index == 2
                          ? title = "Settings".tr
                          : title = "Event".tr;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.price_check),
              label: 'Expense'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.summarize_outlined),
              label: 'Summary'.tr,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings'.tr,
            ),
          ],
          selectedLabelStyle: CommonStyle.black12Bold(),
        ),
      ),
    );
  }
}
