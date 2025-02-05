import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../database/db/diaryPicture_db_service.dart';
import '../../database/db/diary_db_service.dart';
import '../../database/model/diary.dart';
import '../../database/model/diary_picture.dart';
import '../../util/image_util.dart';

class DevUserDiaryFormPage extends StatefulWidget {
  const DevUserDiaryFormPage({super.key});

  @override
  State<DevUserDiaryFormPage> createState() => _DevUserDiaryFormPageState();
}

class _DevUserDiaryFormPageState extends State<DevUserDiaryFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contextController = TextEditingController();
  bool _isChecked = false;
  Uint8List? _selectedImage;

  void _pickImage() async {
    final image = await ImageUtil.pickImage();
    if (image != null) {
      setState(() {
        _selectedImage = image as Uint8List?;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected.')),
      );
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final userDiary = Diary(
        date: _dateController.text,
        time: _timeController.text,
        title: _titleController.text,
        context: _contextController.text,
        isChecked: _isChecked ? 1 : 0,
      );

      print('>>> Saving User Diary: $userDiary');

      // Save the diary and picture
      await DiaryDBService().insert(userDiary);
      if (_selectedImage != null) {
        final userDiaryPicture = DiaryPictures(
            userDiaryId: 1, // Replace with actual ID after inserting the diary
            picture: _selectedImage!);
        print('>>> Saving User Diary Picture');
        await DiaryPictureDBService().insert(userDiaryPicture);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User Diary and Picture saved successfully!'),
      ));

      // Reset the form
      _formKey.currentState!.reset();
      setState(() {
        _selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User Diary'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _dateController,
                decoration:
                    InputDecoration(labelText: 'Date (format: yyyy-MM-dd)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date.';
                  }
                  // format validate
                  if (!RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid date (yyyy-MM-dd).';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time (format: HH:mm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a time.';
                  }
                  // format validate
                  if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(value)) {
                    return 'Please enter a valid time (HH:mm).';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contextController,
                decoration: InputDecoration(labelText: 'Context'),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some context.';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Is Checked?'),
                value: _isChecked,
                onChanged: (value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Select Image'),
              ),
              if (_selectedImage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.memory(_selectedImage!),
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Diary'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
