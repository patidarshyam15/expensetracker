import 'dart:io';
import 'package:expensetracker/storage/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_windows/path_provider_windows.dart';




class DatabaseHelper {
  ///DataBase
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  ///Table Name

  static const tableExpense = 'expenses';
  static const tableInvoiceItems = 'invoice_items';



  /// Items and Cart Items
  static const columnId = 'id';
  static const columnAmount = 'amount';
  static const columnDate = 'date';
  static const columnDescription = 'description';
  static const columnCreatedAt = 'created_at';
  static const columnUpdatedAt = 'updated_at';
  static const columnDeletedAt = 'deleted_at';


  ///

  AppStorage appStorage = AppStorage();

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  Future<Database>? get database async {

    String? isCreated = await appStorage.getDatabaseCreated();

    // print("--isCreated---------------------- $isCreated");
    // print("--_database---------------------- $_database");
    if (_database == null) {
      _database = await _initDatabase();
      // await _onCreate(_database!, _databaseVersion);
      if (isCreated == null) {
        await _onCreate(_database!, _databaseVersion);
      }
    }
    return _database!;
  }


  _initDatabase() async {
    var databaseFactory = databaseFactoryFfi;
    if (Platform.isWindows || Platform.isLinux) {

      sqfliteFfiInit();
      PathProviderWindows? pathProvider = PathProviderWindows();
       String? documentsDirectory = await pathProvider.getApplicationSupportPath();
      String path = join(documentsDirectory!, _databaseName);
      print("inMemoryDatabasePath       ----------- ${path}");
      return await databaseFactory.openDatabase(path);
    } else {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentsDirectory.path, _databaseName);
      print("inPhoneDatabasePath       ----------- ${path}");
      return await databaseFactory.openDatabase(path);
    }
  }


  // SQL code to create the database table
  _onCreate(Database db, int version) async {
    appStorage.setDatabaseCreated("Created");

    await db.execute('''
          CREATE TABLE $tableExpense (
             $columnId INTEGER PRIMARY KEY,
             $columnAmount DOUBLE DEFAULT (0),
             $columnDate DATE,
             $columnDescription TEXT DEFAULT (''),
             $columnCreatedAt DATE,
             $columnUpdatedAt DATE,
             $columnDeletedAt DATE
          )
          ''');

  }




  ///  Data crud

  insertExpensesItems(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert('$tableExpense', row);
  }

  updateExpensesItems(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db!.update('$tableExpense', row,where: '$columnId = ?', whereArgs: [id]);
  }

  deleteExpensesItems(id) async {
    Database? db = await instance.database;
    return await db!.delete('$tableExpense',where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getExpensesItems() async {
    Database? db = await instance.database;
    return await db!.query(tableExpense,orderBy: "$columnId DESC");
  }

  Future<List<Map<String, dynamic>>> getExpensesByDate(selectedDate) async {
    Database? db = await instance.database;
    return await db!.query(tableExpense, where: '$columnDate = ?', whereArgs: [selectedDate],orderBy: "$columnId DESC");
  }

  Future<List<Map<String, dynamic>>> getExpensesBetweenDate(today,lastDate) async {
    Database? db = await instance.database;
    // return await db!.query(tableExpense, where: '$columnDate = ?', whereArgs: [selectedDate],orderBy: "$columnId DESC");
    return await db!.rawQuery("SELECT * FROM $tableExpense where $columnDate between '$lastDate' and '$today'");
  }


  // updateInvoiceItems(Map<String, dynamic> row) async {
  //   Database? db = await instance.database;
  //   int invoices_id = row["invoices_id"];
  //   print('invoices_id---------------------------------------$invoices_id');
  //   return await db!.update('$tableInvoiceItems',  row, where: 'invoices_id = ?', whereArgs: [invoices_id]);
  // }
  // Future<List<Map<String, dynamic>>> queryInvoiceItemsByID(id) async {
  //   Database? db = await instance.database;
  //   return await db!.query(tableInvoiceItems, where: 'invoices_id = ?', whereArgs: [id],orderBy: "$columnId DESC");
  // }
  //
  // deleteAllInvoiceItems() async {
  //   Database? db = await instance.database;
  //   return await db!.delete(tableInvoiceItems);
  // }


}
