import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';




class AppStorage {


  static const OPEN_FIRST_INTRO = 'open_first_intro';
  static const TOKEN = 'token';
  static const USER_EMAIL = 'user_email';
  static const DATABASE_CREATED = 'database_created';



  clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(USER_EMAIL);
  }



  Future<Future<bool>> setFirstIntro(String data)  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(OPEN_FIRST_INTRO, data);
  }

  Future<String?> getFirstIntro() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(OPEN_FIRST_INTRO);
  }

  Future<Future<bool>> setUserEmail(String val)  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(USER_EMAIL, val);
  }

  Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(USER_EMAIL);
  }

  Future<Future<bool>> setDatabaseCreated(String val)  async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(DATABASE_CREATED, val);
  }

  Future<String?> getDatabaseCreated() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(DATABASE_CREATED);
  }

}
