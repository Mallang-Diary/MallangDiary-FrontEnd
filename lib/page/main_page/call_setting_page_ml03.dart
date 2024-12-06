import 'package:flutter/material.dart';

class CallSettingsPage extends StatefulWidget {
  @override
  _CallSettingsPageState createState() => _CallSettingsPageState();
}

class _CallSettingsPageState extends State<CallSettingsPage> {
  // State variables
  List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
  Set<String> selectedDays = {'월', '화', '수', '목', '금', '토', '일'};
  TimeOfDay selectedTime = TimeOfDay.now();

  bool isChanged = false;

  // Check if the user has made any changes
  void _markAsChanged() {
    setState(() {
      isChanged = true;
    });
  }

  // Show time picker
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

  // Save settings
  void _saveSettings() {
    // Perform saving logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('설정이 저장되었습니다.')),
    );
    Navigator.pop(context);
  }

  // Confirm before leaving unsaved changes
  Future<bool> _onWillPop() async {
    if (isChanged) {
      return await showDialog(
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '일기 전화 설정',
            style: TextStyle(
              fontSize: 20, // 글자 크기
              fontWeight: FontWeight.bold,
              color: Colors.black, // 글자 색상
            ),
        ),
        centerTitle: true, // 제목 중앙 정렬
        leading: IconButton(
          //icon: Icon(Icons.arrow_back),
          icon: Image.asset("assets/images/back.png",
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
            // Day Selection
            Text('요일', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: daysOfWeek.map((day) {
                bool isSelected = selectedDays.contains(day);
                return ChoiceChip(
                  label: Text(day),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedDays.add(day);
                      } else if (selectedDays.length > 1) {
                        selectedDays.remove(day);
                      }
                      _markAsChanged();
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            // Time Selection
            Text('시간', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () => _selectTime(context),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  selectedTime.format(context),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Spacer(),
            // Save Button
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
    );
  }
}
