import 'package:flutter/foundation.dart';
import 'package:checkingwork/models/record_model.dart';

class RecordProvider with ChangeNotifier {
  List<RecordModel> _records = [];

  List<RecordModel> get records => _records;

  void addRecord(RecordModel record) {
    _records.add(record);
    notifyListeners();
  }

  List<RecordModel> getRecordsForDate(DateTime date) {
    return _records.where((record) =>
    record.date.year == date.year &&
        record.date.month == date.month &&
        record.date.day == date.day
    ).toList();
  }
}