import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mallang_project_v1/database/db/diary_setting_service.dart';
import 'package:mallang_project_v1/database/model/diary_setting.dart';

class CallerPage extends StatefulWidget {
  // 알람을 백그라운드에서 실행할 수 있도록 개발해야 함
  @override
  State<StatefulWidget> createState() {
    return _CallerPage();  // 실제 UI를 그릴 _CallerPage로 이동
  }
}

class _CallerPage extends State<CallerPage> {
  late DiarySettingService _diarySettingService;
  late Timer _timer;



  late AudioPlayer audioPlayer;
  Color _backgroundColor = Color(0xFF163345);
  Random random = Random();
  String _caller = "";
  String areaCode = "310";
  String prefix = "";
  String lastFour = "";
  List callerList = [
    "Mom",
    "Dog",
    "Wife",
    "Girlfriend",
    "Husband",
    "Boyfriend",
    "OtherHusband",
    "Garbage Man",
    "Bobs Big Shake of Bananas",
  ];
  bool _ringing = false;
  bool _startScreen = true;


  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();

    _diarySettingService = DiarySettingService();
    _startAlarmCheck();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);

  }

  void _startAlarmCheck() {
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      _checkAndRing();
    });
  }

  Future<void> _checkAndRing() async {
    final now = DateTime.now();
    final currentDay = _getCurrentDay(now);
    final currentTime = _getCurrentTime(now);

    final alarmSettings = await _getAlarmSettings();
    for (var setting in alarmSettings) {
      if (setting.dayOfWeek.contains(currentDay) && setting.alarmTime == currentTime) {
        _ring();
        break;
      }
    }
  }

  String _getCurrentDay(DateTime dateTime) {
    final days = ['월', '화', '수', '목', '금', '토', '일'];
    return days[dateTime.weekday - 1];
  }

  String _getCurrentTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  Future<List<DiarySetting>> _getAlarmSettings() async {
    return await _diarySettingService.getDB();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _start() {
    int callerIndex = random.nextInt(callerList.length); // 우리 것은 이 Random 을 사용할 필요가 없을 것같음
    int pre = random.nextInt(899) + 100;
    int lf = random.nextInt(8999) + 1000;
    setState(() {
      prefix = pre.toString();
      lastFour = lf.toString();
      _caller = callerList[callerIndex];
      _startScreen = false;

    });
    _ring();
  }

  void _ring() async {
    // (1). 소스 코드
    _ringing = true;
    do {
      await audioPlayer.play(AssetSource("music/sample_music.mp3"));
      await Future.delayed(Duration(seconds: 3));
    } while(_ringing);

    // (2). play 에러난 부분 고치기 ( _ringing  하는 동안 반복 재생 )
    // 그러면 몇번 음악이 울리고 멈출 것인지에 대한 정책도 반영되어야 함
    /*_ringing = true;
    await audioPlayer.play(AssetSource("sample_music.mp3"));
    audioPlayer.onPlayerComplete.listen((event) async{
      if ( _ringing ){
        await Future.delayed(Duration(seconds: 3));
        await audioPlayer.seek(Duration.zero); // 처음부터 재생
        audioPlayer.resume(); // 재생
      }
    });*/

  }

  void _stopRing() {
    audioPlayer?.stop();
    _ringing = false;
  }

  void _reset() {
    audioPlayer?.stop();
    _ringing = false;
    setState(() {
      _startScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // 디버그 배너 숨기기
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),  // 텍스트 색상 적용
        primarySwatch: Colors.blue,  // 기본 테마 색상
        visualDensity: VisualDensity.adaptivePlatformDensity,  // 화면 밀도에 맞게 적응
      ),
      home: Scaffold(
        backgroundColor: _startScreen ? Colors.black : _backgroundColor,
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  _caller,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  "$areaCode-$prefix-$lastFour",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 2.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.alarm, color: Colors.white, size: 30),
                        Text("Remind Me"),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.message, color: Colors.white, size: 30),
                        Text("Message"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _stopRing,
                          onDoubleTap: _reset,
                          child: FloatingActionButton(
                            heroTag: "decline",
                            child: Icon(Icons.call_end, size: 34),
                            backgroundColor: Colors.red,
                            onPressed: null,
                          ),
                        ),
                        Text("Decline"),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: FloatingActionButton(
                            heroTag: "accept",
                            child: Icon(Icons.phone, size: 34),
                            backgroundColor: Colors.green,
                            onPressed: null,
                          ),
                        ),
                        Text("Accept"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 60),
                ElevatedButton(
                  onPressed: _start,  // 버튼이 눌렸을 때 실행할 함수
                  child: Text("TEMP START"),  // 버튼에 표시될 텍스트
                )
              ],
            ),
            if (_startScreen)
              Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Container(color: Colors.black)
                  ),
                  Expanded(
                      flex: 0,
                      child: GestureDetector(
                        onLongPress: _start,
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          color: Colors.grey[900])
                      ),
                  ),
              ])
          ],
        ),
      ),
    );
  }
}
