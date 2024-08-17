import 'dart:developer';

import 'package:expensetracker/provider_models/expense_provider.dart';
import 'package:expensetracker/provider_models/login_registraion_provider.dart';
import 'package:expensetracker/routes/routes.dart';
import 'package:expensetracker/screens/splash_screen/splash_screen.dart';
import 'package:expensetracker/service/notification_service.dart';
import 'package:expensetracker/service/reminder_service_background.dart';
import 'package:expensetracker/storage/app_storage.dart';
import 'package:expensetracker/storage/local_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'constants/color_const.dart';
import 'language/lang_controller.dart';
import 'language/lang_strings.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  String? isCreated = await AppStorage().getDatabaseCreated();;
  print(" isCreated ------------------ $isCreated");

  final dbHelper = DatabaseHelper.instance;
  Database? db = await dbHelper.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                LoginRegisterProvider()),
        ChangeNotifierProvider(
            create: (_) =>
                ExpenseProvider()),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return GetMaterialApp(
            translations: TranslationText(),
            // locale: Locale('en', 'US'), // Default language
            // fallbackLocale: Locale('en', 'US'), // Fallback language in case of failure
            localizationsDelegates: const [
              // AppLocalization.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            getPages: routes,
            supportedLocales: const <Locale>[
              Locale('en', 'US'), Locale ('ar')
            ],
            initialBinding: BindingsBuilder(() {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.put(LanguageController());
              });

            }),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
            theme: ThemeData(
              primarySwatch: AppColor.myColor,
              primaryColor: AppColor.myColor,
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: AppColor.white), // 1
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.grey),
              useMaterial3: true,
            ),
          );
        },
      ),
    );
  }
}



