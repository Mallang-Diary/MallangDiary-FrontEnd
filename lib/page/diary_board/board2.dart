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
      body: SingleChildScrollView(
        child: Padding(
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
                      Expanded(
                        child: Text(
                          "오늘 오후 5시 일기 전화가 울려요",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
              SizedBox(height: 16),
              // ListView 높이 제한 및 shrinkWrap
              Container(
                height: 400, // ListView의 높이를 제한
                child: _buildDiaryListSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiaryListSection() {
    return ListView(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
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
      ],
    );
  }
}
