import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mallang_project_v1/database/db/diary_db_service.dart';
import 'package:mallang_project_v1/database/db/diary_picture_db_service.dart';
import 'package:mallang_project_v1/database/model/diary.dart';
import 'package:mallang_project_v1/database/model/diary_picture.dart';

class DiaryEditScreen extends StatefulWidget {
  final Diary diary;

  const DiaryEditScreen({Key? key, required this.diary}) : super(key: key);

  @override
  _DiaryEditScreenState createState() => _DiaryEditScreenState();
}

class _DiaryEditScreenState extends State<DiaryEditScreen> {
  final _titleController = TextEditingController();
  final _contextController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  List<DiaryPictures> _pictures = [];

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.diary.title;
    _contextController.text = widget.diary.context;
    _loadPictures();
  }

  Future<void> _loadPictures() async {
    final pictures = await DiaryPictureDBService().getAllDiaryPictures();
    setState(() {
      _pictures = pictures.where((p) => p.userDiaryId == widget.diary.id).toList();
    });
  }

  Future<void> _updateDiary() async {
    final updatedDiary = Diary(
      id: widget.diary.id,
      date: widget.diary.date,
      time: widget.diary.time,
      title: _titleController.text,
      context: _contextController.text,
      isChecked: widget.diary.isChecked,
    );
    await DiaryDBService().insert(updatedDiary);
    Navigator.pop(context, updatedDiary);
  }

  Future<void> _addPicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final newPicture = DiaryPictures(
        userDiaryId: widget.diary.id!,
        picture: bytes,
      );
      await DiaryPictureDBService().insert(newPicture);
      _loadPictures();
    }
  }

  Future<void> _deletePicture(int id) async {
    await DiaryPictureDBService().deleteByUserId(id);
    _loadPictures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("일기 수정하기")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "제목"),
            ),
            TextField(
              controller: _contextController,
              maxLines: 5,
              decoration: InputDecoration(labelText: "내용"),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.add_a_photo),
                  onPressed: _addPicture,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _pictures.map((pic) {
                        return Stack(
                          children: [
                            Image.memory(pic.picture, width: 80, height: 80, fit: BoxFit.cover),
                            Positioned(
                              right: 0,
                              top: 0,
                              child: GestureDetector(
                                onTap: () => _deletePicture(pic.id!),
                                child: Container(
                                  color: Colors.black54,
                                  child: Icon(Icons.close, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateDiary,
              child: Text("저장"),
            ),
          ],
        ),
      ),
    );
  }
}
