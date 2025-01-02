import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/db/user_diary_picture_service.dart';
import '../../database/db/user_diary_service.dart';
import '../../state/app_state.dart';
import 'diary_list_item.dart';

class DiaryList extends StatelessWidget {
  final _userDiaryService = UserDiaryService();
  final _userDiaryPictureService = UserDiaryPictureService();

  DiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    final monthState = context.watch<AppState>();

    // return FutureBuilder(
    //   future: _userDiaryService.getAllByMonth(monthState.currentMonth),
    //   builder: (context, diarySnapshot) {
    //     if (diarySnapshot.connectionState == ConnectionState.waiting) {
    //       return Center(child: CircularProgressIndicator());
    //     } else if (diarySnapshot.hasError) {
    //       return Center(child: Text('Error: ${diarySnapshot.error}'));
    //     }
    //
    //     final diaryList = diarySnapshot.data as List<UserDiary>;
    //     final diaryIds = diaryList.map((diary) => diary.id!).toList();
    //
    //     return FutureBuilder(
    //       future: _userDiaryPictureService.getByUserDiaryIds(diaryIds),
    //       builder: (context, pictureSnapshot) {
    //         if (pictureSnapshot.connectionState == ConnectionState.waiting) {
    //           return Center(child: CircularProgressIndicator());
    //         } else if (pictureSnapshot.hasError) {
    //           return Center(child: Text('Error: ${pictureSnapshot.error}'));
    //         }
    //
    //         final pictureList = pictureSnapshot.data as List<UserDiaryPicture>;
    //
    //         return Column(
    //           children: [
    //             Expanded(
    //               child: ListView(
    //                 shrinkWrap: true,
    //                 children: diaryList
    //                     .map((diary) => DiaryListItem(
    //                           date: DateTime.parse(diary.date),
    //                           title: diary.title,
    //                           isChecked: diary.isChecked == 1,
    //                           content: diary.context,
    //                           images: pictureList
    //                               .where((picture) =>
    //                                   picture.userDiaryId == diary.id)
    //                               .map((picture) =>
    //                                   ImageUtil.uint8ListToAssetImage(
    //                                       picture.picture))
    //                               .toList(),
    //                         ))
    //                     .toList(),
    //               ),
    //             ),
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );
    return Column(
      children: [
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
  }
}
