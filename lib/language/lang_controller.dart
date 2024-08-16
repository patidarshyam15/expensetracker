import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageController extends GetxController {
  final language = ''.obs;

  void changeLanguage(String lang) {
    language.value = lang;
    Get.updateLocale(Locale(lang));
    GetStorage().write('language', lang);
  }


  Future<String?> langData() async {
   return GetStorage().read<String>('language');
  }

  @override
  void onInit() {
    String? storedLang = GetStorage().read<String>('language');
    if (storedLang != null) {
      changeLanguage(storedLang);
    }
    super.onInit();
  }
}
