import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/diary_board/diary_list.dart';
import 'package:mallang_project_v1/page/diary_board/diary_record_card.dart';
import 'package:mallang_project_v1/page/diary_board/month_selector.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Board2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ML01-2'),
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
                    Text("오늘 오후 5시 일기 전화가 울려요"),
                  ],
                ),
                Icon(Icons.settings),
              ],
            ),
            SizedBox(height: 16),
            DiaryRecordCard(),
            Divider(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MonthSelector(),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  DiaryList(
                    date: DateTime.now(),
                    title: "오늘의 일기",
                    isChecked: true,
                    content: "내용내용내용",
                    images: [
                      AssetImage("assets/images/image1.jpg"),
                      AssetImage("assets/images/image2.jpg"),
                      AssetImage("assets/images/image3.jpg"),
                    ],
                  ),
                  DiaryList(
                    date: DateTime.now(),
                    title: "오늘의 일기",
                    isChecked: true,
                    content: "내용내용내용",
                    images: [
                      AssetImage("assets/images/image1.jpg"),
                      AssetImage("assets/images/image2.jpg"),
                      AssetImage("assets/images/image3.jpg"),
                    ],
                  ),
                  // _diaryListTile("10월 7일 어제", "교정 상담 뒤에 펼쳐진 소풍의 행복과 복숭아!"),
                  // _diaryListTile("10월 6일 목요용", "또 다른 일기의 내용입니다."),
                  // 이미지 카드 추가
                  // _imageCard(),
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

  Widget _imageCard() {
    return Container(
      height: 150,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Image.asset("assets/images/image1.jpg"),
          SizedBox(width: 8),
          Image.asset("assets/images/image2.jpg"),
          SizedBox(width: 8),
          Image.asset("assets/images/image3.jpg"),
        ],
      ),
    );
  }
}