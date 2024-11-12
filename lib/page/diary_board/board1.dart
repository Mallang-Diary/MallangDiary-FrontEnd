import 'package:flutter/material.dart';

class Board1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ML01-1'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone),
                    SizedBox(width: 8),
                    Text("예약해둔 일기 전화가 없어요"),
                  ],
                ),
                Icon(Icons.settings),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            Text(
              "10월 8일 오늘",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Center(
              child: CircularProgressIndicator(
                value: 0.4, // 퍼센트 조정
                strokeWidth: 10,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // 일기 녹음 시작
                },
                child: Text("일기 녹음하기"),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "지난 일기 목록",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            // 지난 일기 목록 리스트
            Expanded(
              child: ListView(
                children: [
                  _diaryListTile("10월 7일 어제", "교정 상담 뒤에 펼쳐진 소풍의 행복과 복숭아!"),
                  _diaryListTile("10월 6일 목요일", "또 다른 일기의 내용입니다."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _diaryListTile(String date, String title) {
    return ListTile(
      leading: Icon(Icons.book),
      title: Text(date),
      subtitle: Text(title),
      onTap: () {
        // 일기 상세 보기
      },
    );
  }
}
