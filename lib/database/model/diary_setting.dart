class DiarySetting {
  int? id; // 고유 ID
  int userId; // 사용자 ID
  String dayOfWeek; // 요일 (예: MON, TUE)
  String alarmTime; // 알람 시간 (HH:mm 형태로 저장)
  String alarmSound; // 알람음 경로
  String? createdAt; // 알람 생성 일시

  DiarySetting({
    this.id,
    required this.userId,
    required this.dayOfWeek,
    required this.alarmTime,
    required this.alarmSound,
    this.createdAt,
  });

  factory DiarySetting.fromJson(Map<String, dynamic> json) {

    // 로그 출력
    print("[DiarySetting] 출력 : ${json['createdAt']}");

    return DiarySetting(
      id: json['id'] as int?,
      userId: json['userId'] as int,
      dayOfWeek: json['dayOfWeek'] as String,
      alarmTime: json['alarmTime'] as String,
      alarmSound: json['alarmSound'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'dayOfWeek': dayOfWeek,
      'alarmTime': alarmTime,
      'alarmSound': alarmSound,
      'createdAt': createdAt,
    };
  }
}
