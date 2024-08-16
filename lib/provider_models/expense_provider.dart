import 'dart:convert';
import 'dart:developer';
import 'package:expensetracker/data_models/expense_list_data_model.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/circuler_indicator.dart';
import '../../../storage/app_storage.dart';
import '../../../utils/common_validators.dart';
import '../constants/date_time_format.dart';
import '../custom_widgets/toasts_alert.dart';
import '../language/lang_controller.dart';
import '../storage/local_database.dart';





class ExpenseProvider extends ChangeNotifier with CommonValidations {
  AppStorage appStorage = AppStorage();
  bool _loading = true;
  bool get loading => _loading;
  List<String> tabTitle = ['Weekly'.tr,'Monthly'.tr];
  setLoading(val){
    _loading = val;
    notifyListeners();
  }

  final dbHelper = DatabaseHelper.instance;

  TextEditingController _searchCtrl = TextEditingController();
  TextEditingController get searchCtrl => _searchCtrl;

  setSearchDate(DateTime date){
    _searchCtrl.text = Format.datePass.format(date);
    notifyListeners();
    getExpensesByDate();
  }


  TextEditingController _amountCtrl = TextEditingController();
  TextEditingController get amountCtrl => _amountCtrl;

  TextEditingController _descriptionCtrl = TextEditingController();
  TextEditingController get descriptionCtrl => _descriptionCtrl;

  TextEditingController _dateCtrl = TextEditingController();
  TextEditingController get dateCtrl => _dateCtrl;

  setStartDate(DateTime date){
    _dateCtrl.text = Format.datePass.format(date);
    notifyListeners();
  }

  int? editExpenseId = 0;

  setEditExpense(ExpenseListData expense) async {
    _descriptionCtrl.text = expense.description;
    _dateCtrl.text = expense.date;
    _amountCtrl.text = expense.amount.toString();
    editExpenseId = expense.id;
    notifyListeners();
  }

  submitExpense({required bool isEdit}){
    if(_amountCtrl.text.isEmpty){
      errorToastMessage("Amount required".tr);
    } else if(_dateCtrl.text.isEmpty){
      errorToastMessage("Select date".tr);
    }else if(_descriptionCtrl.text.isEmpty){
      errorToastMessage("Description required".tr);
    }else{
      isEdit?editExpense():addExpense();
    }
  }

  void addExpense() async {
    Dialogs.showLoadingDialog();
    Map<String, dynamic> row = {
      DatabaseHelper.columnAmount: double.parse(_amountCtrl.text),
      DatabaseHelper.columnDate: _dateCtrl.text,
      DatabaseHelper.columnDescription: _descriptionCtrl.text,
    };
    var id = await dbHelper.insertExpensesItems(row);
    log("inserted row -- $id");
    clearAll();
    getExpenses();
    Get.back();
    Get.back();
  }

  void editExpense() async {
    Dialogs.showLoadingDialog();
    Map<String, dynamic> row = {
      DatabaseHelper.columnId: editExpenseId,
      DatabaseHelper.columnAmount: double.parse(_amountCtrl.text),
      DatabaseHelper.columnDate: _dateCtrl.text,
      DatabaseHelper.columnDescription: _descriptionCtrl.text,
    };
    var id = await dbHelper.updateExpensesItems(row);
    log("updated row -- $id");
    clearAll();
    getExpenses();
    Get.back();
    Get.back();
  }

  void deleteExpense(expenseId) async {

    var id = await dbHelper.deleteExpensesItems(expenseId);
    log("deleted row -- $id");
    clearAll();
    getExpenses();
    Get.back();
  }

  List<ExpenseListData> _expenseList = [];
  List<ExpenseListData> get expenseList => _expenseList;

  void getExpenses() async {
    setLoading(true);
    final allRows =
    await dbHelper.getExpensesItems();
    log('query all rows:\n');
    allRows.forEach(print);
    // print(json.encode(allRows));
    _expenseList = List<ExpenseListData>.from(
        allRows.map((x) => ExpenseListData.fromJson(x)));
    setLoading(false);
    notifyListeners();
  }

  void getExpensesByDate() async {
    setLoading(true);
    final allRows =
    await dbHelper.getExpensesByDate(_searchCtrl.text);
    log('query all rows:\n');
    allRows.forEach(print);
    // print(json.encode(allRows));
    _expenseList = List<ExpenseListData>.from(
        allRows.map((x) => ExpenseListData.fromJson(x)));
    setLoading(false);
    notifyListeners();
  }

  void getExpensesWeekly() async {
    setLoading(true);
    final allRows =
    await dbHelper.getExpensesByDate(_searchCtrl.text);
    log('query all rows:\n');
    allRows.forEach(print);
    // print(json.encode(allRows));
    _expenseList = List<ExpenseListData>.from(
        allRows.map((x) => ExpenseListData.fromJson(x)));
    setLoading(false);
    notifyListeners();
  }

  void getExpensesMonthly() async {
    setLoading(true);
    final allRows =
    await dbHelper.getExpensesByDate(_searchCtrl.text);
    log('query all rows:\n');
    allRows.forEach(print);
    // print(json.encode(allRows));
    _expenseList = List<ExpenseListData>.from(
        allRows.map((x) => ExpenseListData.fromJson(x)));
    setLoading(false);
    notifyListeners();
  }

  String? langData = "";
  String? get lang => langData!;

  setLangData(val) async {
    final LanguageController languageController = Get.find();
    languageController.changeLanguage('$val'); // Change language to Arabic
    langData = await languageController.langData();
    notifyListeners();
    print("$langData");
    notifyListeners();
  }


  clearAll() async {
    FlutterBackgroundService().invoke("setAsBackground");
    final LanguageController languageController = Get.find();
    var language  = await languageController.langData();
    langData = language ?? "en";
    _amountCtrl.clear();
    _descriptionCtrl.clear();
    _dateCtrl.clear();
    _expenseList = [];
    editExpenseId = 0;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }

}
