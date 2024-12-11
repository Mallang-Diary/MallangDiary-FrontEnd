import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mallang_project_v1/database/db/diary_setting_service.dart';
import 'package:mallang_project_v1/database/db/user_service.dart';

class CompletePage extends StatefulWidget {

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
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0), // 전체 여백 추가
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Text를 왼쪽 정렬
          children: [
            Text(
              "일기 쓸 준비 완료!",
              textAlign: TextAlign.left, // 왼쪽 정렬
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}