// db class
import 'dart:typed_data';

class DiaryPictures {
  final int? id;
  final int userDiaryId;
  final Uint8List picture;

  DiaryPictures({
    this.id,
    required this.userDiaryId,
    required this.picture,
  });

  factory DiaryPictures.fromJson(Map<String, dynamic> json) {
    return DiaryPictures(
        id: json['id'] as int?,
        userDiaryId: json['userDiaryId'] as int,
        picture: json['picture'] as Uint8List);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userDiaryId': userDiaryId,
      'picture': picture,
    };
  }
}
