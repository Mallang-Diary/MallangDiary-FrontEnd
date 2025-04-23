import 'package:flutter/material.dart';
import 'package:mallang_project_v1/database/db/user_diary_service.dart';
import 'package:mallang_project_v1/database/db/user_diary_picture_service.dart';
import 'package:mallang_project_v1/database/model/user_diary.dart';
import 'package:mallang_project_v1/database/model/user_diary_picture.dart';

class DevDBViewPage extends StatefulWidget {
  @override
  _DevDBViewPageState createState() => _DevDBViewPageState();
}

class _DevDBViewPageState extends State<DevDBViewPage> {
  final UserDiaryService _diaryService = UserDiaryService();
  final UserDiaryPictureService _pictureService = UserDiaryPictureService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Database Contents'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Diaries'),
              Tab(text: 'Pictures'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 일기 데이터 탭
            FutureBuilder<List<UserDiary>>(
              future: _diaryService.getDB(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final diaries = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: diaries.length,
                  itemBuilder: (context, index) {
                    final diary = diaries[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        title: Text('${diary.date} - ${diary.title}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${diary.id}'),
                            Text('Time: ${diary.time}'),
                            Text('Content: ${diary.context}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            // 사진 데이터 탭
            FutureBuilder<List<UserDiaryPicture>>(
              future: _pictureService.getAll(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final pictures = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: pictures.length,
                  itemBuilder: (context, index) {
                    final picture = pictures[index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('Picture ID: ${picture.id}'),
                            subtitle: Text('Diary ID: ${picture.userDiaryId}'),
                          ),
                          if (picture.picture != null)
                            Image.memory(
                              picture.picture,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
