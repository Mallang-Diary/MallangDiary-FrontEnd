// db class
class UserDiaryPicture {
  final int? id;
  final int userDiaryId;
  final String picturePath;

  UserDiaryPicture({
    this.id,
    required this.userDiaryId,
    required this.picturePath,
  });

  factory UserDiaryPicture.fromJson(Map<String, dynamic> json) {
    return UserDiaryPicture(
      id: json['id'] as int,
      userDiaryId: json['userDiaryId'] as int,
      picturePath: json['picturePath'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userDiaryId': userDiaryId,
      'picturePath': picturePath,
    };
  }
}
