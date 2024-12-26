import 'package:flutter/material.dart';
import 'package:mallang_project_v1/page/diary_board/month_selector.dart';
import 'package:provider/provider.dart';

import '../../database/db/user_diary_service.dart';
import '../../database/model/user_diary.dart';
import '../../state/app_state.dart';
import 'diary_list_item.dart';

class DiaryList extends StatelessWidget {
  final _userDiaryService = UserDiaryService();

  DiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    final monthState = context.watch<AppState>();

    return FutureBuilder(
      future: _userDiaryService.getAllByMonth(monthState.currentMonth),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final diaryList = snapshot.data as List<UserDiary>;

        return Column(
          children: [
            MonthSelector(),
            Expanded(
                child: ListView(shrinkWrap: true, children: [
              DiaryListItem(
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
              DiaryListItem(
                date: DateTime.now(),
                title: "10월 6일 목요일",
                isChecked: false,
                content: "또 다른 일기의 내용입니다.",
                images: [
                  AssetImage("assets/images/image2.jpg"),
                  AssetImage("assets/images/image3.jpg"),
                ],
              ),
            ])),
          ],
        );
      },
    );
  }
}
