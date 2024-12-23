import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/diary_setting_service.dart';
import 'package:mallang_project_v1/page/diary_board/diary_list.dart';
import 'package:mallang_project_v1/page/diary_board/diary_record_card.dart';
import 'package:mallang_project_v1/page/diary_board/month_selector.dart';

class Board2Page extends StatefulWidget {
  @override
  _Board2PageState createState() => _Board2PageState();
}

class _Board2PageState extends State<Board2Page> {
  final DiarySettingService diarySettingService = DiarySettingService();
  String currentSettingText = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadDiarySetting();
  }

  Future<void> _loadDiarySetting() async {
    try {
      final settings = await diarySettingService.getDB();
      if (settings.isNotEmpty) {
        setState(() {
          currentSettingText =
          "${settings.first.dayOfWeek} ${settings.first.alarmTime} 알림이 울립니다";
        });
      } else {
        setState(() {
          currentSettingText = "알람 설정 정보가 없습니다.";
        });
      }
    } catch (e) {
      print("Error loading diary settings: $e");
      setState(() {
        currentSettingText = "일정 정보를 불러오는 중 에러가 발생했습니다.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),

            Container(
              width: MediaQuery.of(context).size.width, // 화면 너비의 90%로 제한
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!), // 회색 테두리
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  currentSettingText,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  icon: Icon(Icons.person_3_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/mypage_ml04');
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            DiaryRecordCard(),
            Divider(),
            SizedBox(height: 16),
            MonthSelector(),
            Expanded(
              child: ListView(
                children: [
                  DiaryList(
                    date: DateTime.now(),
                    title: "10월 7일 어제",
                    isChecked: true,
                    content: "교정 상담 뒤에 펼쳐진 소풍의 행복과 복숭아!",
                    images: [
                      AssetImage("assets/images/image1.jpg"),
                      AssetImage("assets/images/image2.jpg"),
                      AssetImage("assets/images/image3.jpg"),
                    ],
                  ),
                  DiaryList(
                    date: DateTime.now(),
                    title: "10월 6일 목요일",
                    isChecked: false,
                    content: "또 다른 일기의 내용입니다.",
                    images: [
                      AssetImage("assets/images/image2.jpg"),
                      AssetImage("assets/images/image3.jpg"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
