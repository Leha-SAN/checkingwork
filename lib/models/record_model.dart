import 'package:flutter/foundation.dart';

class RecordModel {
  final String category;
  final String subcategory;
  final DateTime date;
  final String hoursQuantity;

  RecordModel({
    required this.category,
    required this.subcategory,
    required this.date,
    required this.hoursQuantity,
  });

  @override
  String toString() {
    return 'RecordModel{category: $category, subcategory: $subcategory, date: $date, hoursQuantity: $hoursQuantity}';
  }
}

