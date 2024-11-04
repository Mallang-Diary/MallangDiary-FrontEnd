import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp( // 최상단 그릇
      home: Scaffold( // home: 필수적으로 필요한 요소 Scaffold : 발판, 앱을 구성하기 위한 뼈대
        backgroundColor: Colors.white, // 배경색
        body: Center( // 몸통, 중간
          child: Text(
            'hello World',
            style: TextStyle(
              fontSize: 40.0,
              color: Colors.black,
            ),
          ),
        ), // 여기에서 , 추가 후 주석 처리
      ),
    ),
  );
}