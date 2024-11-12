import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/caller/recording_complete_page.dart';
import 'recording_complete_page.dart';

class RecordingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ML06'), backgroundColor: Colors.black),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('녹음 중', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('00:10 / 05:00', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('취소'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordingCompletePage()),
                    );
                  },
                  child: Text('저장'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
