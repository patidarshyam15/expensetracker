import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

import 'package:get/get.dart';

mixin CommonValidations {
  static const int passwordMinLength = 8;
  static const int phoneMaxDigit = 10;
  static const int otpCount = 4;

  // static constants int phoneMinDigit = 10;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<bool> internetConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
        return true;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        return true;
      } else {
        return false;
      }
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return false;
    }
  }
  String? isValidPassword(String? password) {
    RegExp rex =
    RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$");

    if (password == null || password.isEmpty) {
      return 'Password is required'.tr;
    } /*else if (password.length < 8) {
      return 'Password should be at least 8 characters long.';
    } *//*else if (!rex.hasMatch(password)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character.';
    }*/ else {
      return null;
    }
  }

  String? isValidConfirmPassword(String? password, String? confirmPassword) {
    // RegExp rex = RegExp(r"^[a-z]{6}$");
    if (password == null || password.isEmpty) {
      return 'Confirm Password should be required.';
    } else if (password.length < passwordMinLength) {
      return "Password should be at least $passwordMinLength characters long.";
    }
    // else if (!rex.hasMatch(password)) {
    //   return "Password should contain only lowercase letters.";
    // }
    else if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Please confirm your password.';
    } else if (password != confirmPassword) {
      return 'Passwords do not match.';
    } else {
      return null;
    }
  }

  String? isValidEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email ID is required'.tr;
    }
    final isValid = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(email.trim());

    if (isValid) {
      return null;
    } else {
      return 'Enter valid Email ID'.tr;
    }
  }

  String? isValidMobile(String? mobile) {
    if (mobile == null || mobile.isEmpty) {
      return 'Mobile should be required.';
    } else if (mobile.trim().isEmpty) {
      return 'Mobile should be required.';
    } else if (mobile.length != phoneMaxDigit) {
      return 'Mobile should be 10 digit.';
    } else {
      return null;
    }
  }

  String? isRequired(String? value, String field) {
    if (value == null || value.isEmpty) {
      return '$field'+" "+"is required";
    } else if (value.trim().isEmpty) {
      return '$field'+" "+"is required";
    } else {
      return null;
    }
  }

  String? isPwdSame({required String pin1,required String pin2}) {
    if (pin2 != pin1) {
      return "Mismatch";
    }  else {
      return null;
    }
  }

  String? isSelected(String? value, String field) {
    if (value == null || value.isEmpty) {
      return 'please select $field';
    } else if (value.trim().isEmpty) {
      return '$field should be required.';
    } else {
      return null;
    }
  }

  String? isChecked(bool value, String field) {
    if (value == false ) {
      return 'please check $field';
    } else {
      return null;
    }
  }
  String? isVerified(bool value, String field) {
    if (value == false ) {
      return 'please verify $field';
    } else {
      return null;
    }
  }
}
