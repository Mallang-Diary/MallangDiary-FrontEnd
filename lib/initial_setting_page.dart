import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InitialSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Initial Setting Page'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.grey.withOpacity(0.5),
          ),
          Center(
            child: Padding(padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "세상과 연결하세요",
                )
              ],
            ),),
          )
        ],
      )
    );
  }

}