import 'dart:async';
import 'dart:typed_data';

class UserDiary {
  // 날짜 하나에 내용과 사진 여러개가 담길 수 있어서
  // 날짜 값이 id 랑 비슷한 primary key 가 되어야 할 것같기도 하고
  int? id;
  String? date;
  String? time;
  String context;
  Uint8List pictureList;
  // 녹음 파일도 추가하기

  UserDiary({
    this.id,
    this.date,
    this.time,
    required this.context,
    required this.pictureList,
  });
  // 내일 녹음 파일을 local android 내부 파일에 저장되는지도 확인
  // ai api 연결도 필요할 듯
  factory UserDiary.fromJson(Map<String, dynamic> json) {
    return UserDiary(
        id: json['id'] as int?,
        date: json['date'] as String?,
        time: json['time'] as String?,
        context: json['context'] as String,
        pictureList: json['pictureList'] as Uint8List
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'date' : date,
      'time' : time,
      'context' : context,
      'pictureList' : pictureList,
    };
  }


}

// 날짜
// 내용
// 사진
// 녹음 파일 등