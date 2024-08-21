import 'package:flutter/material.dart';

class DateInheritedWidget extends InheritedWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateChanged;

  const DateInheritedWidget({
    Key? key,
    required Widget child,
    required this.selectedDate,
    required this.onDateChanged,
  }) : super(key: key, child: child);

  static DateInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DateInheritedWidget>();
  }

  @override
  bool updateShouldNotify(covariant DateInheritedWidget oldWidget) {
    return selectedDate != oldWidget.selectedDate;
  }
}