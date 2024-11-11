import 'package:flutter/material.dart';

class CompletePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CompletePage();
  }
}

class _CompletePage extends State<CompletePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("일기 쓸 준비 완료!", textAlign: TextAlign.center),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
}