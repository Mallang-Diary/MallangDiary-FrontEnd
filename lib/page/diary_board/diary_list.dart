import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/model/diary.dart';
import 'package:mallang_project_v1/util/image_util.dart';
import 'package:provider/provider.dart';

import '../../database/db/diary_picture_db_service.dart';
import '../../database/db/diary_db_service.dart';
import '../../state/app_state.dart';
import 'diary_list_item.dart';

class DiaryList extends StatelessWidget {
  final DiaryDBService _diaryService = DiaryDBService();
  final DiaryPictureDBService _pictureService = DiaryPictureDBService();

  DiaryList({super.key});

  @override
  Widget build(BuildContext context) {
    final monthState = context.watch<AppState>();

    return FutureBuilder<List>(
      future: _diaryService.getAllByMonth(monthState.currentMonth),
      builder: (context, diarySnapshot) {
        if (diarySnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (diarySnapshot.hasError) {
          return Center(child: Text('Error: ${diarySnapshot.error}'));
        }
        if (!diarySnapshot.hasData || (diarySnapshot.data as List).isEmpty) {
          return const Center(child: Text('해당 월의 일기가 없습니다.'));
        }

        final List<Diary> diaryList = diarySnapshot.data as List<Diary>;
        // 각 일기의 id 목록 추출 (null이 아니라고 가정)
        final diaryIds = diaryList.map((diary) => diary.id!).toList();

        return FutureBuilder<List>(
          future: _pictureService.getByUserDiaryIds(diaryIds),
          builder: (context, pictureSnapshot) {
            if (pictureSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (pictureSnapshot.hasError) {
              return Center(child: Text('Error: ${pictureSnapshot.error}'));
            }
            // 사진 데이터가 없을 수도 있으므로 기본값 []를 사용
            final List pictureList = pictureSnapshot.data ?? [];

            return ListView.builder(
              itemCount: diaryList.length,
              itemBuilder: (context, index) {
                final diary = diaryList[index];
                // 해당 일기의 사진들만 필터링
                final diaryImages = pictureList
                    .where((picture) => picture.userDiaryId == diary.id)
                    .map((picture) =>
                        // 여기서 ImageUtil.uint8ListToAssetImage()는
                        // BLOB 데이터를 이미지 위젯으로 변환하는 함수입니다.
                        ImageUtil.uint8ListToAssetImage(picture.picture))
                    .toList();

                return DiaryListItem(
                  date: DateTime.parse(diary.date),
                  title: diary.title,
                  isChecked: diary.isChecked == 1,
                  content: diary.context,
                  images: diaryImages,
                );
              },
            );
          },
        );
      },
    );
  }
}
