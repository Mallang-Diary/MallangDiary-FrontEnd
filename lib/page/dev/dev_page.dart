// flutter test page

import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/dev/dev_user_diary_form_page.dart';
import 'package:mallang_project_v1/page/diary_board/board2.dart';
import 'package:mallang_project_v1/page/dev/dev_db_view_page.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dev Test Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Board2Page();
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DevDBViewPage();
                }));
              },
              child: Text('View Database Contents'),
            ),
          ],
        ),
      ),
    );
  }
}
