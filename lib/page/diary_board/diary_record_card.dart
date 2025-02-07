import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../caller/recording_page.dart';

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
        Center(
          child: CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 12.0,
            percent: 0.4,
            startAngle: 180,
            backgroundColor: Colors.grey[200]!,
            progressColor: Colors.black12,
            animation: true,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "2분 10초",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                "3분",
                style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ]
            ),
            arcType: ArcType.HALF,
          ),
        ),
        Center(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RecordingPage()),
              );
            },
            icon: Icon(
              Icons.mic,
              color: Colors.white,
              size: 24,
            ),
            label: Text(
              "일기 녹음하기",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(height: 18),
        Text(
          "일기는 자정이 지나면 자동으로 생성되며 재생성되지 않습니다.",
          style: TextStyle(fontSize: 14, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
