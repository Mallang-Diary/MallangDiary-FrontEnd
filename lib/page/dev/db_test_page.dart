// flutter test page

import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/diarySetting_db_service.dart';
import 'package:mallang_project_v1/database/db/diary_picture_db_service.dart';
import 'package:mallang_project_v1/database/db/diary_db_service.dart';
import 'package:mallang_project_v1/database/db/user_db_service.dart';
import 'package:mallang_project_v1/page/dev/dev_user_diary_form_page.dart';
import 'package:mallang_project_v1/page/diary_board/main_board.dart';

class DBTestPage extends StatelessWidget {
  DBTestPage({super.key});

  final TextEditingController _userIdController = TextEditingController();

  final userDBService = UserDBService();
  final diaryDBService = DiaryDBService();
  final diaryPictureDBService = DiaryPictureDBService();
  final diarySettingDBService = DiarySettingDBService();

  Future<void> deleteUserDataById(BuildContext context) async {
    final String userIdText = _userIdController.text.trim();

    if (userIdText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("사용자 ID 를 입력하세요")),
      );
      return;
    }

    final int? userId = int.tryParse(userIdText);
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("유효한 숫자를 입력하세요.")),
      );
      return;
    }

    try {
      await diaryPictureDBService.deleteByUserId(userId);
      await diaryDBService.deleteByUserId(userId);
      await diarySettingDBService.deleteByUserId(userId);
      await userDBService.deleteById(userId);

      // Success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("ID $userId 관련 데이터가 모두 삭제되었습니다.")),
      );
    } catch (e) {
      print("Error deleting data: $e");

      // Fail
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("삭제 중 오류가 발생했습니다.: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dev Test Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainBoardPage();
                  }));
                },
                child: Text('Main Page')),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DevUserDiaryFormPage();
                }));
              },
              child: Text('Create Dummy User Diary'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _userIdController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '사용자 ID 입력',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => deleteUserDataById(context),
              child: Text('입력한 ID 데이터 삭제'),
            ),
          ],
        ),
      ),
    );
  }
}
