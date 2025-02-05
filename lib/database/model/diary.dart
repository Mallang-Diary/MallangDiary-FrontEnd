class Diary {
  int? id;
  String date;
  String time;
  String title;
  String context;
  int isChecked;

  // 녹음 파일 추가 예정
  // 녹음 파일 -> local android 내부 저장소로 저장 필요

  Diary(
      {this.id,
      required this.date,
      required this.time,
      required this.title,
      required this.context,
      required this.isChecked});

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        id: json['id'] as int,
        date: json['date'] as String,
        time: json['time'] as String,
        title: json['title'] as String,
        context: json['context'] as String,
        isChecked: json['isChecked'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'time': time,
      'title': title,
      'context': context,
      'isChecked': isChecked
    };
  }
}
