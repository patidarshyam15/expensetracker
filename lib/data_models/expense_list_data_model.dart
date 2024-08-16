// To parse this JSON data, do
//
//     final expenseListData = expenseListDataFromJson(jsonString);

import 'dart:convert';

List<ExpenseListData> expenseListDataFromJson(String str) => List<ExpenseListData>.from(json.decode(str).map((x) => ExpenseListData.fromJson(x)));

String expenseListDataToJson(List<ExpenseListData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ExpenseListData {
  int id;
  double amount;
  String date;
  String description;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  ExpenseListData({
    required this.id,
    required this.amount,
    required this.date,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory ExpenseListData.fromJson(Map<String, dynamic> json) => ExpenseListData(
    id: json["id"],
    amount: json["amount"],
    date: json["date"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "date": date,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
  };
}
