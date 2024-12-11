import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DiaryRecordCard extends StatelessWidget {
  const DiaryRecordCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "2024년 10월 8일 오늘",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        // CircularPercentIndicator를 제한된 SizedBox로 감쌈
        Center(
          child: SizedBox(
            height: 200, // 부모 영역에 제한된 공간 설정
            width: 200,
            child: CircularPercentIndicator(
              radius: 100.0,
              lineWidth: 20.0,
              percent: 0.4,
              startAngle: 180,
              backgroundColor: Colors.grey[300]!,
              progressColor: Colors.blue,
              animation: true,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                "2분 10초",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              arcType: ArcType.HALF,
            ),
          ),
        ),
        SizedBox(height: 8), // 여백 추가
        ElevatedButton(
          onPressed: () {
            print("일기 녹음하기");
          },
          child: Text("일기 녹음하기"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(height: 8),
        Text(
          "일기는 지정된 시간이 지나면 자동으로 생성되며 재생성되지 않습니다.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
