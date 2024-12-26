// db class
import 'dart:typed_data';

class UserDiaryPicture {
  final int? id;
  final int userDiaryId;
  final Uint8List picture;

  UserDiaryPicture({
    this.id,
    required this.userDiaryId,
    required this.picture,
  });

  factory UserDiaryPicture.fromJson(Map<String, dynamic> json) {
    return UserDiaryPicture(
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
