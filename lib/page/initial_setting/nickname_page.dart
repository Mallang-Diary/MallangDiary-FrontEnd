import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'callschedule_page.dart';

class NickNamePage extends StatefulWidget {
  final Function(String) onNickNameEntered;

  NickNamePage({required this.onNickNameEntered});

  @override
  _NickNamePageState createState() => _NickNamePageState();
}

class _NickNamePageState extends State<NickNamePage> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 컨트롤러 리스너를 통해 입력 이벤트 감지
    _nicknameController.addListener(() {
      widget.onNickNameEntered(_nicknameController.text);
    });
  }

  @override
  void dispose() {
    // 컨트롤러 해제
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              '안녕하세요.\n당신을 어떻게 불러드릴까요?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
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
          ],
        ),
      ),
    );
  }
}