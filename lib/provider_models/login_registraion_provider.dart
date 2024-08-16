
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../storage/app_storage.dart';
import '../../../utils/common_validators.dart';
import '../custom_widgets/circuler_indicator.dart';
import '../custom_widgets/toasts_alert.dart';
import '../routes/route_name.dart';
import '../service/reminder_service_background.dart';


class LoginRegisterProvider extends ChangeNotifier with CommonValidations {
  AppStorage appStorage = AppStorage();
  static GlobalKey<NavigatorState> loadingKey = GlobalKey<NavigatorState>();
  bool _loading = false;
  bool get loading => _loading;
  bool _obSecure = true;
  bool get obSecure => _obSecure;
  int _selectedToggle = 0;
  int get selectedToggle => _selectedToggle;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  setObSecure(val){
    _obSecure = val;
    notifyListeners();
  }
  setSelectedToggle(val){
    _selectedToggle = val;
    notifyListeners();
  }


  /// Login
  TextEditingController _loginEmailCtrl = TextEditingController();
  TextEditingController _loginPwdCtrl = TextEditingController();
  TextEditingController get loginEmailCtrl => _loginEmailCtrl;
  TextEditingController get pwdCtrl => _loginPwdCtrl;

  /// Register

  TextEditingController _registerEmailCtrl = TextEditingController();
  TextEditingController _registerPwdCtrl = TextEditingController();
  TextEditingController _registerConfirmPwdCtrl = TextEditingController();
  TextEditingController get registerEmailCtrl => _registerEmailCtrl;
  TextEditingController get registerPwdCtrl => _registerPwdCtrl;
  TextEditingController get registerConfirmPwdCtrl => _registerConfirmPwdCtrl;


  submitSignIn(){
    String? emailError = isValidEmail(_loginEmailCtrl.text);
    String? passwordError = isValidPassword(_loginPwdCtrl.text);
    if(emailError != null){
      errorToastMessage(emailError);
    }else if (passwordError != null) {
      errorToastMessage(passwordError);
    }else{
      login();
    }
  }

  void login() async {
    await internetConnectivity().then((value) async {
      if(value == true){
        Dialogs.showLoadingDialog();
        try {
          final email = _loginEmailCtrl.text;
          final password = _loginPwdCtrl.text;
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          if (userCredential.user != null) {
            log("Login--------${userCredential.user!}");
            Get.back();
            await appStorage.setUserEmail(json.encode(userCredential.user!.email));
            notifyListeners();
            bool isServiceRunning = await FlutterBackgroundService().isRunning();
            if(!isServiceRunning){
              await initializeService();
            }
            Get.offNamedUntil(RouteName.BOTTOM_NAV_BAR, (route) => false);
            successToastMessage("Login Successfully".tr);
          }else{
            Get.back();
          }
        } catch (e) {
          print(e);
          Get.back();
          errorToastMessage("Login failed: $e");
        }
      }else{
        errorToastMessage("Please check your Internet Connection".tr);
      }
    });
  }

  submitSignUp(){
    String? emailError = isValidEmail(_registerEmailCtrl.text);
    String? passwordError = isValidPassword(_registerPwdCtrl.text);
    if(emailError != null){
      errorToastMessage(emailError);
    } else if (passwordError != null) {
      errorToastMessage(passwordError);
    } else if (_registerPwdCtrl.text != _registerConfirmPwdCtrl.text) {
      errorToastMessage("Password mismatch".tr);
    } else{
      signUp();
    }
  }

  void signUp() async {
    await internetConnectivity().then((value) async {
      if(value == true){
        Dialogs.showLoadingDialog();
        try {
          final email = _registerEmailCtrl.text;
          final password = _registerConfirmPwdCtrl.text;
          UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          if (userCredential.user != null) {
            log("register--------${userCredential.user}");
           _registerEmailCtrl.clear();
             _registerConfirmPwdCtrl.clear();
            setSelectedToggle(0);
            Get.back();
            successToastMessage("Registration Successfully".tr);
          }else{
            Get.back();
          }
        } catch (e) {
          print(e);
          Get.back();
          errorToastMessage("Registration failed: $e");
        }
      }else{
        errorToastMessage("Please check your Internet Connection".tr);
      }
    });
  }



  clearTextCtrl() {
    _registerEmailCtrl.clear();
    _registerPwdCtrl.clear();
    _registerConfirmPwdCtrl.clear();
    _loginEmailCtrl.clear();
    _loginPwdCtrl.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.dispose();
  }
}
