import 'package:flutter/material.dart';

import 'callschedule_page.dart';

class NickNamePage extends StatelessWidget {
  final Function(String) onNickNameEntered;
  final TextEditingController _nicknameController = TextEditingController();

  NickNamePage({required this.onNickNameEntered});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('닉네임 설정'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '안녕하세요.\n당신을 어떻게 불러드릴까요?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: '닉네임',
                hintText: '2~10자',
              ),
              maxLength: 10,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                if (_nicknameController.text.length >= 2) {
                  onNickNameEntered(_nicknameController.text);
                }
              },
              child: Text('다음으로'),
            ),
          ],
        ),
      ),
    );
  }
}