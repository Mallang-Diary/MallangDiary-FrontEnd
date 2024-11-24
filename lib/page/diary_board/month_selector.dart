import 'package:flutter/material.dart';
import 'package:mallang_project_v1/main.dart';
import 'package:mallang_project_v1/state/app_state.dart';
import 'package:provider/provider.dart';

class MonthSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final monthState = context.watch<AppState>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: monthState.previousMonth,
        ),
        Row(
          children: [
            Icon(Icons.calendar_today, size: 20),
            SizedBox(width: 8),
            Text(
              "${monthState.currentMonth.year}년 ${monthState.currentMonth.month}월",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: monthState.nextMonth,
        ),
      ],
    );
  }
}
