import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:mallang_project_v1/page/caller/recording_complete_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'recording_complete_page.dart';

class RecordingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecordingPage();
  }
}

class _RecordingPage extends State<RecordingPage> {
  late FlutterSoundRecorder _recorder;
  late String _recordingPath;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      final tempDir = await getTemporaryDirectory();
      _recordingPath = '${tempDir.path}/recording.mp3';
      await _recorder.startRecorder(toFile: _recordingPath);
      setState(() {
        _isRecording = true;
      });
    } else {
      // 권한 요청이 거부된 경우
      print("녹음 권한이 필요합니다.");
    }
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<void> _saveRecording() async {
    final directory = await getApplicationDocumentsDirectory(); // 앱의 문서 디렉토리 가져오기
    final savedPath = '${directory.path}/saved_recording.mp3';
    File(_recordingPath).copy(savedPath).then((file) {
      print("녹음 파일 저장됨: $savedPath");
      // 녹음 저장 후 추가적인 작업이 필요할 경우 여기서 처리
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('녹음 중', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('00:10 / 05:00', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _isRecording ? _stopRecording() : _startRecording();
                  },
                  child: Text(_isRecording ? '중지' : '녹음 시작'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecordingCompletePage()),
                    );
                  },
                  child: Text('저장'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
