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

class RecordProvider with ChangeNotifier {
  final List<RecordModel> _records = [];

  List<RecordModel> get records => _records;

  void addRecord(RecordModel record) {
    _records.add(record);
    notifyListeners();
  }

  List<RecordModel> getRecordsForDate(DateTime date) {
    return _records.where((record) => isSameDate(record.date, date)).toList();
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
}