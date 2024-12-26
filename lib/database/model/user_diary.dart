import 'dart:typed_data';

class UserDiary {
  // 날짜 하나에 내용과 사진 여러개가 담길 수 있어서
  // 날짜 값이 id 랑 비슷한 primary key 가 되어야 할 것같기도 하고
  int id;
  String date;
  String time;
  String title;
  String context;
  Uint8List pictureList; // 추후 삭제 고려 (다대일 관리를 위해 user_diary_picture로 테이블 분리)
  bool isChecked;
  // 녹음 파일도 추가하기

  UserDiary(
      {required this.id,
      required this.date,
      required this.time,
      required this.title,
      required this.context,
      required this.pictureList,
      required this.isChecked});
  // 내일 녹음 파일을 local android 내부 파일에 저장되는지도 확인
  // ai api 연결도 필요할 듯
  factory UserDiary.fromJson(Map<String, dynamic> json) {
    return UserDiary(
        id: json['id'] as int,
        date: json['date'] as String,
        time: json['time'] as String,
        title: json['title'] as String,
        context: json['context'] as String,
        pictureList: json['pictureList'] as Uint8List,
        isChecked: json['isChecked'] as bool);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'title': title,
      'context': context,
      'pictureList': pictureList,
      'isChecked': isChecked
    };
  }
}

// 날짜
// 내용
// 사진
// 녹음 파일 등
