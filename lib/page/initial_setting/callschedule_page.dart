import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mallang_project_v1/page/initial_setting/complete_page.dart';
import 'package:mallang_project_v1/theme/colors.dart';

class CallSchedulePage extends StatefulWidget {
  final String nickname;
  final Function(String, String) onScheduleChanged; // Callback 함수

  CallSchedulePage({
    required this.nickname,
    required this.onScheduleChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return _CallSchedulePageState();
  }
}

class _CallSchedulePageState extends State<CallSchedulePage> {
  List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  List<bool> selectedDays = List<bool>.filled(7, false);
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);
  bool isChanged = false;

  void _markAsChanged() {
    setState(() {
      isChanged = true;
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        _markAsChanged();
      });
    }
  }

  String getSelectedDays() {
    return daysOfWeek.asMap().entries
        .where((entry) => selectedDays[entry.key])
        .map((entry) => entry.value)
        .join(',');
  }

  String _getSelectedDaysString() {
    return daysOfWeek
        .asMap()
        .entries
        .where((entry) => selectedDays[entry.key])
        .map((entry) => entry.value)
        .join(',');
  }

  String _getSelectedTimeString() {
    return '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}';
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // 스크롤 가능하도록 감싸기
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                '${widget.nickname}님,\n언제 일기 전화를 드릴까요?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24),
              Text(
                '요일',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              // 요일 선택 UI
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(daysOfWeek.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDays[index] = !selectedDays[index];
                        _markAsChanged();
                        widget.onScheduleChanged(_getSelectedDaysString(), selectedTime.format(context));
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedDays[index] ? buttonColorLightGrey : Colors.white,
                        border: Border.all(color: buttonColorLightGrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        daysOfWeek[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              Text(
                '시간',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    selectedTime.format(context),
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
