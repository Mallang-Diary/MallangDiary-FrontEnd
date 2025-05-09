import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/diary_setting_service.dart';
import 'package:mallang_project_v1/page/diary_board/diary_list.dart';
import 'package:mallang_project_v1/page/diary_board/diary_record_card.dart';

import 'month_selector.dart';

class Board2Page extends StatefulWidget {
  @override
  _Board2PageState createState() => _Board2PageState();
}

class _Board2PageState extends State<Board2Page> {
  final DiarySettingService _diarySettingService = DiarySettingService();
  String currentSettingText = "Loading...";

  @override
  void initState() {
    super.initState();
    _loadDiarySetting();
  }

  Future<void> _loadDiarySetting() async {
    try {
      final settings = await _diarySettingService.getDB();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // 뒤로가기 (for dev test page)
              if (Navigator.canPop(context))
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey[400]!),
              //     borderRadius: BorderRadius.circular(8),
              //   ),
              //   child: ListTile(
              //     leading: Icon(Icons.phone),
              //     title: Text(
              //       currentSettingText,
              //       style: TextStyle(fontSize: 16),
              //       overflow: TextOverflow.ellipsis,
              //     ),
              //     trailing: IconButton(
              //       icon: Icon(Icons.person_3_outlined),
              //       onPressed: () {
              //         Navigator.pushNamed(context, '/mypage_ml04');
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(height: 16),
              DiaryRecordCard(),
              Divider(),
              SizedBox(height: 16),
              MonthSelector(),
              DiaryList(),
            ],
          ),
        ),
      ),
    );
  }
}
