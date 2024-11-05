import 'package:flutter/material.dart';

class CallSchedulePage extends StatefulWidget {
  final String nickname;

  CallSchedulePage({required this.nickname});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CallSchedulePageState();
  }
}

class _CallSchedulePageState extends State<CallSchedulePage> {

  String selectedDay = "월";
  TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('일기 전화 일정 설정'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Text(
              '${widget.nickname}님, 언제 일기 전화를 드릴까요?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['월', '화', '수', '목', '금', '토', '일']
                  .map((day) => ChoiceChip(
                label: Text(day),
                selected: selectedDay == day,
                onSelected: (bool selected) {
                  setState(() {
                    selectedDay = day;
                  });
                },
                selectedColor: Colors.blue, // 선택된 색상
                backgroundColor: Colors.grey[200], // 비선택 색상
              ))
                  .toList(),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${selectedTime.format(context)}',
                  style: TextStyle(fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (picked != null && picked != selectedTime) {
                      setState(() {
                        selectedTime = picked;
                      });
                    }
                  },
                  child: Text('시간 선택'),
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('나중에'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 다음 단계로 이동
                  },
                  child: Text('다음으로'),
                ),
              ],
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}