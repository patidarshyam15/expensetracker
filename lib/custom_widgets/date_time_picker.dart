import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class DateTimePick {

   Future<DateTime?> pickDate() async {
   DateTime? pickedDate =  await showDatePicker(
       context: Get.context!,
       initialDate: DateTime.now(),
       firstDate: DateTime(1950),
       lastDate: DateTime.now(),
       builder: (BuildContext context, Widget? child) {
         return Theme(
           data: ThemeData.light().copyWith(
             colorScheme: ColorScheme.fromSwatch(
               primarySwatch: Colors.orange,
             ),),
           child: child!,
         );
       },
     );
   log("pickedDate-- $pickedDate");
   return pickedDate;

   }

   Future<TimeOfDay?> pickTime() async {
     TimeOfDay? pickedTime =  await showTimePicker(
       context: Get.context!,
       builder: (BuildContext context, Widget? child) {
         return Theme(
           data: ThemeData.light().copyWith(
             colorScheme: ColorScheme.fromSwatch(
               primarySwatch: Colors.orange,
             ),),
           child: child!,
         );
       }, initialTime: TimeOfDay.now(),

     );
     log("pickedTime-- ${pickedTime?.period.name}");
     log("pickedTime-- ${pickedTime!.replacing(hour: pickedTime.hourOfPeriod)}");
   return pickedTime;

   }

}