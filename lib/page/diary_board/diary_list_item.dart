import 'package:flutter/material.dart';

class DiaryListItem extends StatelessWidget {
  final DateTime date;
  final String title;
  final String content;
  final List<Image> images;

  const DiaryListItem({
    super.key,
    required this.date,
    required this.title,
    required this.content,
    required this.images,
  });

  // 요일 변환
  String _getFormattedDate(DateTime date) {
    final List<String> weekdays = [
      "월요일",
      "화요일",
      "수요일",
      "목요일",
      "금요일",
      "토요일",
      "일요일",
    ];
    return "${date.year}년 ${date.month}월 ${date.day}일 ${weekdays[date.weekday - 1]}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _getFormattedDate(date),
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 12),

          // 본문 텍스트
          Text(
            content,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 16),

          // 이미지 그리드
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2열로 배치
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: images[index],
              );
            },
          ),
        ],
      ),
    );
  }
}
