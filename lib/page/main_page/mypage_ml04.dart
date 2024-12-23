import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/user_diary_service.dart';
import 'package:mallang_project_v1/database/db/user_service.dart';
import 'package:mallang_project_v1/database/model/user.dart';

class MyPage extends StatelessWidget {
  final UserService _userService = UserService();
  final UserDiaryService _userDiaryService = UserDiaryService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _userService.getUser(),
          _userDiaryService.countAll(),
          _userDiaryService.countThisMonth()
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = snapshot.data![0] as User;
          final diaryCount = snapshot.data![1] as int;
          final diaryThisMonthCount = snapshot.data![2] as int;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white, // AppBar 배경색
              elevation: 0, // 그림자 제거
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
              title: Text(
                "마이페이지",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // 제목 글자 크기
                  fontWeight: FontWeight.bold, // 제목 글자 굵기
                ),
              ),
              centerTitle: true, // 제목 중앙 정렬
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${user.nickname}의 일기",
                    style: TextStyle(
                      fontSize: 18, // 제목 글자 크기
                      fontWeight: FontWeight.bold, // 제목 글자 굵기
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatBox(
                        label: "총 일기 개수",
                        value: "$diaryCount개",
                      ),
                      _StatBox(
                        label: "이번달 일기 개수",
                        value: "$diaryThisMonthCount개",
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  _MenuItem(
                    icon: Icons.alarm,
                    title: "일기 전화 설정",
                    onTap: () {
                      // 해당 페이지로 이동 로직 추가
                    },
                  ),
                  _MenuItem(
                    icon: Icons.delete,
                    title: "데이터 삭제",
                    onTap: () {
                      // 해당 페이지로 이동 로직 추가
                    },
                  ),
                  _MenuItem(
                    icon: Icons.privacy_tip,
                    title: "개인정보 처리방침",
                    onTap: () {
                      // 해당 페이지로 이동 로직 추가
                    },
                  ),
                  Spacer(),
                  Center(
                    child: Text(
                      "ver. 1.221",
                      style: TextStyle(
                        fontSize: 12, // 버전 글자 크기
                        color: Colors.grey, // 색상
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // 너비 설정
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!), // 테두리 색상
        borderRadius: BorderRadius.circular(10), // 모서리 둥글게
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14, // 라벨 글자 크기
              color: Colors.grey, // 라벨 색상
            ),
          ),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20, // 값 글자 크기
              fontWeight: FontWeight.bold, // 값 굵게
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem(
      {required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey, size: 20), // 아이콘
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16, // 메뉴 글자 크기
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16), // 화살표
          ],
        ),
      ),
    );
  }
}
