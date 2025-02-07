import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/diary_board/main_board.dart';


class RecordingCompletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('녹음 완료!', style: TextStyle(fontSize: 24, fontWeight:FontWeight.bold)),
            SizedBox(height: 250),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainBoardPage()
                    ),
                  );
                },
                label: Text(
                  "일기 메인으로 이동하기",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
