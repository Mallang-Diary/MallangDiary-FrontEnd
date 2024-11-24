import 'package:flutter/widgets.dart';

class AppState extends ChangeNotifier {
  var currentMonth = DateTime.now();

  void previousMonth() {
    currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    notifyListeners();
  }

  void nextMonth() {
    currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    notifyListeners();
  }
}
