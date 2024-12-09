import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class User {
  int? id;
  String? nickname;

  User({
    this.id,
    this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User (
      id: json['id'] as int?,
      nickname: json['nickname'] as String?,
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id' : id,
      'nickname': nickname,
    };
  }
}