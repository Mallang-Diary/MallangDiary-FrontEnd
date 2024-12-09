import 'package:flutter/material.dart';
import 'package:mallang_project_v1/theme/colors.dart';

class CallSettingsPage extends StatefulWidget {
  @override
  _CallSettingsPageState createState() => _CallSettingsPageState();
}

class _CallSettingsPageState extends State<CallSettingsPage> {
  final List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  late List<bool> selectedDays;
  TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 0);

  bool isChanged = false;

  @override
  void initState() {
    super.initState();
    selectedDays = List<bool>.filled(daysOfWeek.length, true);
  }

  void _markAsChanged() {
    setState(() {
      isChanged = true;
    });
  }

  void _selectTime(BuildContext context) async {
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

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('설정이 저장되었습니다.')),
    );
    Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    if (isChanged) {
      return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('변경 사항이 저장되지 않았습니다.'),
          content: Text('정말 나가시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('나가기'),
            ),
          ],
        ),
      ) ??
          false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '일기 전화 설정',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Image.asset(
              "assets/images/back.png",
              width: 24,
              height: 24,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('요일', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(daysOfWeek.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDays[index] = !selectedDays[index];
                        _markAsChanged();
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: selectedDays[index] ? Colors.grey[200] : Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        daysOfWeek[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: selectedDays[index] ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 16),
              Text('시간', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: buttonColorLightGrey ?? Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    selectedTime.format(context),
                    style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: isChanged ? _saveSettings : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('저장'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 추가 고려 사항
// 1. 요일별로 알람 시간 설정을 가능하도록 개발해야 한다.