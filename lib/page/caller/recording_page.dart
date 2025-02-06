import 'dart:io';
import 'dart:async';
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
  late Timer _timer;
  int _elapsedTime = 0;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();
  }

  Future<void> _initializeRecorder() async {
    await _recorder.openRecorder();
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _timer.cancel();
    super.dispose();
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (status.isGranted) {
      final now = DateTime.now();
      final formattedDate = "${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}";
      final tempDir = await getTemporaryDirectory();
      _recordingPath = '${tempDir.path}/recording_$formattedDate';

      await _recorder.startRecorder(toFile: _recordingPath);

      setState(() {
        _isRecording = true;
        _elapsedTime = 0;
      });

      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _elapsedTime++;
        });

        // 녹음 시간이 5분 ( 300초 )를 넘기면 녹음을 중지하고 알림창을 띄운다.
        if ( _elapsedTime >= 300 ){
          _timer.cancel();
          _stopRecording();
          _showStopRecordingDialog();
        }

      });

    } else {
      // 권한 요청이 거부된 경우
      print("녹음 권한이 필요합니다.");
    }
  }

  // Recording 을 Save() 하는 곳
  Future<void> _saveRecording() async {
    final directory = await getApplicationDocumentsDirectory(); // 앱의 문서 디렉토리 가져오기
    final savedPath = '${directory.path}/saved_recording.mp3';
    File(_recordingPath).copy(savedPath).then((file) {
      print("녹음 파일 저장됨: $savedPath");
      // 녹음 저장 후 추가적인 작업이 필요할 경우 여기서 처리
    });
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    _timer.cancel();

    setState(() {
      _isRecording = false;
    });
  }

  void _showStopRecordingDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('늑음 종료'),
        content: Text('5분이 지나 녹음이 자동으로 중지되었습니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _saveRecording();
            },
            child: Text('저장'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('취소'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    // elaplseTime ( 경과 시간 ), 시, 분, 초 형식으로 변환
    final minutes = (_elapsedTime / 60).floor();
    final seconds = _elapsedTime % 60;
    final duration = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isRecording)
              Text('녹음 중', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('$duration / 05:00', style: TextStyle(fontSize: 16, color: Colors.grey)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if ( _isRecording ) {
                        _stopRecording();
                      }
                      else {
                        _startRecording();
                      }
                    });
                  },
                  child: Text(_isRecording ? '중지' : '녹음 시작'), ///////////// 이 부분도 수정해야 할 것같음
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
