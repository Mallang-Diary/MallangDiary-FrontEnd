import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'recording_page.dart';

class CallingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CallingPage();
  }
}

class _CallingPage extends State<CallingPage> {
  late AudioPlayer audioPlayer;
  Random random = Random();
  bool _ringing = false;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    _ring();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  }

  void _ring() async {
    _ringing = true;
    do {
      // music 은 어떻게 할 것인지 정해야 함
      await audioPlayer.play(AssetSource("music/sample_music.mp3"));
      await Future.delayed(Duration(seconds: 3));
    } while(_ringing);

  }

  void _stopRing() {
    audioPlayer?.stop();
    _ringing = false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        visualDensity: VisualDensity.adaptivePlatformDensity,  // 화면 밀도에 맞게 적응
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(''), backgroundColor: Colors.black),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  '일기 전화 오는 중..',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 2.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: _stopRing,
                          child: Container(
                            //width: 80,
                            // /height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: FloatingActionButton(
                              heroTag: "decline",
                              child: Icon(Icons.close, size: 34, color: Colors.black),
                              backgroundColor: Colors.white,
                              onPressed: null,
                            ),
                          )
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>RecordingPage()),
                            );
                          },
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.black,
                            child: Icon(Icons.mic, size: 34, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height /10)
              ]
            )
          ],
        )
      )
    );
  }

}
