import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/diary_setting_service.dart';
import 'package:mallang_project_v1/database/db/user_service.dart';

import '../../database/model/diary_setting.dart';
import '../../database/model/user.dart';

class CompletePage extends StatefulWidget {
  final String nickname;
  final String selectedDays;
  final String selectedTime;

  CompletePage({required this.nickname, required this.selectedDays, required this.selectedTime});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CompletePage();
  }
}

class _CompletePage extends State<CompletePage> {
  final UserService _userService = UserService();
  final DiarySettingService _diarySettingService = DiarySettingService();

  @override
  void initState() {
    super.initState();
    saveData();
  }

  Future<void> saveData() async {

    print("DB 저장 ${widget.nickname} - ${widget.selectedDays} - ${widget.selectedTime}");
    try {
      final userExists = await _userService.userExists();
      if (!userExists) {
        await _userService.insert(User( nickname: widget.nickname));
      }

      final diarySetting = DiarySetting(
        userId: 1,
        dayOfWeek: widget.selectedDays,
        alarmTime: widget.selectedTime,
        alarmSound: "default",
        createdAt: DateTime.now(),
      );

      await _diarySettingService.insert(diarySetting);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("저장 완료")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("저장 실패")),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("일기 쓸 준비 완료!", textAlign: TextAlign.center),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
}