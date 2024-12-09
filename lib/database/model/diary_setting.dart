import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DiarySetting {
  int? id; // 고유 ID
  int userId; // 사용자 ID
  String dayOfWeek; // 요일 (예: MON, TUE)
  String alarmTime; // 알람 시간 (HH:mm 형태로 저장)
  String alarmSound; // 알람음 경로
  DateTime? createdAt; // 알람 생성 일시

  DiarySetting({
    this.id,
    required this.userId,
    required this.dayOfWeek,
    required this.alarmTime,
    required this.alarmSound,
    this.createdAt,
  });

  /// JSON 데이터를 DiarySetting 인스턴스로 변환
  factory DiarySetting.fromJson(Map<String, dynamic> json) {
    return DiarySetting(
      id: json['id'] as int?,
      userId: json['user_id'] as int,
      dayOfWeek: json['day_of_week'] as String,
      alarmTime: json['alarm_time'] as String,
      alarmSound: json['alarm_sound'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at']) // JSON의 타임스탬프를 Dart DateTime으로 변환
          : null,
    );
  }

  // [ 사용법 ]
  // DiarySetting diarySetting = DiarySetting.fromJson(jsonResponse);
  // print(diarySetting.dayOfWeek); // MON

  /// DiarySetting 인스턴스를 JSON 형태로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'day_of_week': dayOfWeek,
      'alarm_time': alarmTime,
      'alarm_sound': alarmSound,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

// [ 사용법 ]
// final jsonData = diarySetting.toJson();
// print(jsonData);